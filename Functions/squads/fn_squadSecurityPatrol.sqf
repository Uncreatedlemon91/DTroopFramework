// Sends a patrol out to a location in order to increase it's security level.
params ["_missionPacket", "_missionLocation"];

_battData = _missionPacket select 2;

// Plan the mission 
_squadType = "Infantry";
_mkrType = "";
_groupType = "";
_dest = (_missionLocation select 2);
_missionType = (_missionPacket select 0);

// Define the Marker Type
switch (_battData select 0) do {
	case "USA": {_mkrType = "b_inf"; _groupType = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01"};
	case "ARVN": {_mkrType = "n_inf"; _groupType = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_01"};
	case "PAVN": {_mkrType = "o_inf"; _groupType = configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_field" >> "vn_o_group_men_nva_field_01"};
};

// Create a marker 
_mkr = createMarkerLocal [format ["%1-%2-%3", _battData select 1, _missionPacket select 0], _battData select 3];
_mkr setMarkerTypeLocal _mkrType;
_mkr setMarkerTextLocal (_missionPacket select 0);
_mkr setMarkerSize [0.3, 0.3];

// Add the Marker to the Hashmap for Active Squads 
_active = false;
LemonActiveSquads set [_mkr, [_battData, _missionPacket, _missionLocation, _groupType, _active]];

// Function to check for players routinely 
[_mkr] remoteExec ["lmn_fnc_squadCheckPlayers", 2];

// Move the marker
[_mkr, getMarkerPos _mkr, _dest, 50, "man"] remoteExec ["lmn_fnc_squadMoveMarker", 2];

// Wait for the squad to arrive 
waitUntil {
	sleep 5;
	_dist = (getMarkerPos _mkr) distance2d _dest;
	_dist < 15;
};

// Run patrol on the area (sleep while virtual) 
systemChat "Patrolling";
sleep random 50;

// Return the squad back to battalion HQ 
systemChat "Returning!";
[_mkr, getMarkerPos _mkr, _battData select 3, 50, "man"] remoteExec ["lmn_fnc_squadMoveMarker", 2];

waitUntil {
	sleep 5;
	_dist = (getMarkerPos _mkr) distance2d (_battData select 3);
	_dist < 15;
};

// Provide security boost to the location 
_oldSecLevel = _missionLocation select 4;
_newSecLevel = _oldSecLevel + 5;
_missionLocation set [4, _newSecLevel];
LemonLocations set [_missionPacket select 1, _missionLocation];

// Delete the marker
LemonActiveSquads deleteAt _mkr;
deleteMarker _mkr;
