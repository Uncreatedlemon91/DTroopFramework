// Tactical commander that directs an Ambush assault 
params ["_trig", "_playerCount"];

// Discover amount of groups to send 
_groupsToSend = 1;
if (_playerCount > 0) then {
	_groupsToSend = random [1, 2, 3];
};
if (_playerCount > 7) then {
	_groupsToSend = random [2, 3, 4];
};
if (_playerCount > 10) then {
	_groupsToSend = random [3, 4, 5];
};

// Select faction 
_faction = _trig getVariable "Faction";

for "_i" from 1 to _groupsToSend do {
	_spawnFaction = "";
	_spawnSide = "";
	_cfgClass = "";
	switch (_faction) do {
		case "USA": {_spawnSide = west; _cfgClass = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sog"};
		case "PAVN": {_spawnSide = east; _cfgClass = configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local"};
		case "ARVN": {_spawnSide = independent; _cfgClass = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_ranger"};
	};
	_troopGroup = createGroup _spawnSide;
	_troopGroup deleteGroupWhenEmpty true;
	_troopGroup setVariable ["lambs_danger_enableGroupReinforce", true, true];

	// Select the troops to send 
	_squad = selectRandom ("true" configClasses (_cfgClass));
	_units = "true" configClasses (_squad);
	systemChat format ["%1", _units];
	{
		_class = getText (_x >> 'vehicle');
		_unit = _troopGroup createUnit [_class, position _trig, [], 10, "FORM"];
		zeus addCuratorEditableObjects [[_unit], true];
		sleep 0.02;
	} forEach _units;

	// Assign a mission to the troops 
	_tasking = selectRandom ["defendDefend", "defendGarrison", "defendPatrol"];
	switch (_tasking) do {
		case "defendDefend": {[_troopGroup, position _troopGroup, 250] spawn lambs_wp_fnc_taskDefend;};
		case "defendGarrison": {[_troopGroup, position _troopGroup, 250] call lambs_wp_fnc_taskGarrison;};
		case "defendPatrol": {[_troopGroup, 600] spawn lambs_wp_fnc_taskPatrol};
	};

	// Update the trigger to reflect how many forces are active 
	_activeTroops = _trig getVariable ["ActiveTroops", 0];
	_newCount = _activeTroops + (count units _troopGroup);
	_trig setVariable ["ActiveTroops", _newCount];

	// Update the trigger for all the groups that are active for cleanup purposes
	_activeGroups = _trig getVariable ["ActiveGroups", []];
	_activeGroups pushback _troopGroup;
	_trig setVariable ["ActiveGroups", _troopGroup];

	// Add group level event handlers to reduce Troop Count on casualties 
	_troopGroup setVariable ["attachedTrigger", _trig];
	_troopGroup addEventHandler ["UnitKilled", {
		params ["_group", "_unit", "_killer", "_instigator", "_useEffects"];
		_trig = _group getVariable "attachedTrigger";
		_currentForceCount = _trig getVariable "TroopCount";
		_newCount = _currentForceCount - 1;
		_trig setVariable ["TroopCount", _newCount];
	}];
};
