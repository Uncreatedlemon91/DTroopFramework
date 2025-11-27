// Moves a battalion 
params ["_batt", "_dest"];
systemchat format ["Moving %1", _batt];
/*
(calculatePath ["man", "safe", getMarkerPos _batt, _dest]) addEventHandler ["PathCalculated", {
	{
		_marker = createMarker ["marker" + str _forEachIndex, _x];
		_marker setMarkerType "mil_dot";
		_marker setMarkerText str _forEachIndex;
		[_batt, _dest, 30, 0] call BIS_fnc_moveMarker;
	} forEach (_this select 1);
}];
*/

// _path = calculatePath ["man", "SAFE", getMarkerPos _batt, _dest];
// systemChat format ["Path: %1", _path];

// Move the marker 
_dist = _dest distance (getMarkerPos _batt); 
_speed = _dist / 10;
[_batt, _dest, _speed, 0] call BIS_fnc_moveMarker;