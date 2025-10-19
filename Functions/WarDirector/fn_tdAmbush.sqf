// Tactical commander that directs an Ambush assault 
params ["_trig"];

// Stop script if no Troops available in reserve
_troopCount = _trig getVariable "TroopCount";
if (_troopCount == 0) exitWith {};

// Select faction 
_faction = _trig getVariable "Faction";
_spawnFaction = "";
_spawnSide = "";
_cfgClass = "";
switch (_faction) do {
	case "USA": {_spawnFaction = lmn_US; _spawnSide = west; _cfgClass = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sog"};
	case "PAVN": {_spawnFaction = lmn_PAVN; _spawnSide = east; _cfgClass = configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local"};
	case "ARVN": {_spawnFaction = lmn_ARVN; _spawnSide = independent; _cfgClass = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_ranger"};
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
_tasking = selectRandom ["ambushCreep", "ambushRush", "ambushHunt"];
switch (_tasking) do {
	case "ambushCreep": {[_troopGroup, 600] spawn lambs_wp_fnc_taskCreep};
	case "ambushRush": {[_troopGroup, 600] spawn lambs_wp_fnc_taskRush};
	case "ambushHunt": {[_troopGroup, 600] spawn lambs_wp_fnc_taskHunt};
};

// Add group level event handlers to reduce Troop Count on casualties 
_troopGroup setVariable ["attachedTrigger", _trig];
_troopGroup addEventHandler ["UnitKilled", {
	params ["_group", "_unit", "_killer", "_instigator", "_useEffects"];
	_trig = _group getVariable "attachedTrigger";
	_currentForceCount = _trig getVariable "TroopCount";
	_newCount = _currentForceCount - 1;
	_trig setVariable ["TroopCount", _newCount];
}];

