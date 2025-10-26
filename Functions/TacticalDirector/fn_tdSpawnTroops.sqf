// Spawns forces into the AO 
params ["_data", "_mission", "_trig"];

// Select faction 
_faction = _data select 2;
_spawnPos = [(_data select 1), 0, 50, 5, 0, 3] call BIS_fnc_findSafePos;
_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];

_spawnFaction = "";
_spawnSide = "";
_cfgClass = "";
switch (_faction) do {
	case "USA": {_spawnSide = west; _cfgClass = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sog"};
	case "PAVN": {_spawnSide = east; _cfgClass = configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_field"};
	case "ARVN": {_spawnSide = independent; _cfgClass = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_ranger"};
};
_troopGroup = createGroup _spawnSide;
_troopGroup deleteGroupWhenEmpty true;
_troopGroup setVariable ["lambs_danger_enableGroupReinforce", true, true];

// Select the troops to send 
_squad = selectRandom ("true" configClasses (_cfgClass));
_units = "true" configClasses (_squad);
_activeUnits = _trig getVariable ["ActiveTroops", []];
{
	_class = getText (_x >> 'vehicle');
	_unit = _troopGroup createUnit [_class, _spawnPos, [], 10, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];
	// Add unit to Troop roster of trigger 
	_activeUnits pushback _unit; 
	sleep 0.02;
} forEach _units;
_trig setVariable ["ActiveTroops", _activeUnits, true];

// Assign a mission to the troops 
switch (_mission) do {
	case "Patrol": {[_troopGroup, _spawnPos, 200] call BIS_fnc_taskPatrol};
	case "Ambush": {if (_faction != "PAVN") then {[_troopGroup, _spawnPos, 200] call BIS_fnc_taskPatrol} else {[_troopGroup, 1200] spawn lambs_wp_fnc_taskCreep}};
	case "Hunt": {if (_faction != "PAVN") then {[_troopGroup, _spawnPos, 200] call BIS_fnc_taskPatrol} else {[_troopGroup, 1200] spawn lambs_wp_fnc_taskHunt}};
	case "Attack": {[_troopGroup, 1200] spawn lambs_wp_fnc_taskRush};
	case "Defend": {[_troopGroup, _spawnPos, 150] call lambs_wp_fnc_taskGarrison};
};

// Add group level event handlers to reduce Troop Count on casualties 
_troopGroup setVariable ["attachedLocation", _data select 11];
_troopGroup addEventHandler ["UnitKilled", {
	params ["_group", "_unit", "_killer", "_instigator", "_useEffects"];
	_loc = _group getVariable "attachedLocation";
	_trig = _group getVariable "attachedTrigger";
	_db = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	_data = ["read", [_loc, "Data"]] call _db;

	_currentForceCount = _data select 3;
	_newCount = _currentForceCount - 1;
	_data set [3, _newCount];
	[_data] remoteExec ["lmn_fnc_saveLocation", 2];

	// Update the trigger 
	_activeTroops = _trig getVariable ["ActiveTroops", []];
	_index = _activeTroops find _unit;
	_activeTroops deleteAt _index;
	_trig setVariable ["ActiveTroops", _activeTroops, true];
}];