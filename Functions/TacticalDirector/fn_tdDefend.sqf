// Tactical commander that directs an Ambush assault 
params ["_data"];

// Select faction 
_faction = _data select 2;
_spawnPos = [(_data select 1), 0, 100, 5, 0, 3] call BIS_fnc_findSafePos;
_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];

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
{
	_class = getText (_x >> 'vehicle');
	_unit = _troopGroup createUnit [_class, _spawnPos, [], 10, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];
	// Add unit to Troop roster of trigger 
	_activeUnits = _trig getVariable ["ActiveUnits", []];
	_activeUnits pushback _unit;  
	_trig setVariable ["ActiveUnits", _activeUnits];
	_newCount = count _activeUnits;
	_trig setVariable ["ActiveTroops", _newCount];
	sleep 0.02;
} forEach _units;

// Assign a mission to the troops 
_tasking = selectRandom ["defendGarrison", "defendPatrol"];
switch (_tasking) do {
	case "defendGarrison": {[_troopGroup, position _trig, 250] call lambs_wp_fnc_taskGarrison;};
	case "defendPatrol": {[_troopGroup, _spawnPos, 600] call BIS_fnc_taskPatrol;};
};

// Add group level event handlers to reduce Troop Count on casualties 
_troopGroup setVariable ["attachedLocation", _data select 11];
_troopGroup addEventHandler ["UnitKilled", {
	params ["_group", "_unit", "_killer", "_instigator", "_useEffects"];
	_loc = _group getVariable "attachedTrigger";
	_db = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	_data = ["read", [_loc, "Data"]] call _db;

	_currentForceCount = _data select 3;
	_newCount = _currentForceCount - 1;
	_data set [3, _newCount];
	[_data] remoteExec ["lmn_fnc_saveDatabase", 2];
}];
	