// Spawns the squad, deletes the old marker and creates a new one 
params ["_mkr"];

// Get the Hashmap Data 
_data = LemonActiveSquads get _mkr;
_battData = _data select 0;
_missionPacket = _data select 1;
_missionLocation = _data select 2;
_groupType = _data select 3;
_active = _data select 4;
_mkrType = _data select 5;

if (_active) exitWith {systemChat "Unit already Spawned!"};

// Spawn the unit 
_data set [4, true];
LemonActiveSquads set [_mkr, _data];

_side = "";
switch (_battData select 0) do {
	case "USA": {_side = west};
	case "ARVN": {_side = independent};
	case "PAVN": {_side = east};
};
_grp = [getMarkerPos _mkr, _side, _groupType] call BIS_fnc_spawnGroup; // Need to remove this as it's too costly without a sleep command
_grp deleteGroupWhenEmpty true;

// Update Marker 
[_mkr, getMarkerPos _mkr, 0, 0] call BIS_fnc_moveMarker;

// Move the marker with group leader 
[_mkr, _grp] remoteExec ["lmn_fnc_squadAttachMarker", 2];

// Give orders to the unit
[_grp, _missionLocation select 2, 150] call BIS_fnc_taskPatrol;