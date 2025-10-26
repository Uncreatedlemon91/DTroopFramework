// Sends troops from one location to another. These are physical units that move around the map. 
params ["_source", "_destination"];

systemChat "Spawning Reinforcments!";

// Get Variables 
_faction = _source select 2;
_troopCount = _source select 3;
_spawnSide = "";
_cfgClass = "";

// Change variables based on faction 
switch (_faction) do {
	case "USA": {_spawnSide = west; _cfgClass = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sog"};
	case "PAVN": {_spawnSide = east; _cfgClass = selectRandom [configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_motor_nva", configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_field", configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_mech_nva"]};
	case "ARVN": {_spawnSide = independent; _cfgClass = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_ranger"};
};

// Set spawn location and spawn unit 
_spawnPos = [_source select 1, 0, 100, 5, 0, 3] call BIS_fnc_findSafePos;
_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];
_squad = selectRandom ("true" configClasses (_cfgClass));
_units = "true" configClasses (_squad);
_troopGroup = createGroup _spawnSide;
_troopGroup deleteGroupWhenEmpty true;
_troopGroup setVariable ["lambs_danger_enableGroupReinforce", true, true];
{
	_class = getText (_x >> 'vehicle');
	_unit = _troopGroup createUnit [_class, _spawnPos, [], 10, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];	
	sleep 0.02;
} forEach _units;

// Give troop a location to get to 
_wp1 = _troopGroup addWaypoint [_destination select 1, 20, 1];
_wp1 setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "MOVE";

// Remove the count of troops from the trigger 
_groupCount = count (units _troopGroup);
_newTroopCount = _troopCount - _groupCount;
_source set [3, _newTroopCount];

// Sync database 
[_source] remoteExec ["lmn_fnc_saveLocation", 2];

// Delete the unit and add them to the destination if they get there succesfully 
waitUntil { (getPos (leader _troopGroup) distance (_destination select 1)) < 30; };
 
{
	deleteVehicle _x;
} forEach units _troopGroup;

_oldTroopLevel = _destination getVariable "TroopLevel";
_newTroopLevel = _groupCount + _oldTroopLevel;
_destination set [3, _newTroopLevel];

// Sync database 
[_destination] remoteExec ["lmn_fnc_saveLocation", 2];