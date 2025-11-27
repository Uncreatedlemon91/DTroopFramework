// Checks the area for nearby players 
params ["_mkr"];
_loop = true;
while {true} do {
	{
		_mkrPos = getMarkerPos _mkr;
		if ([_mkrPos, [0,0,0]] call BIS_fnc_arrayCompare) exitWith {_loop = false; systemChat "Marker has been deleted!"};
		// Current result is saved in variable _x
		if (_x distance _mkrPos < 400) exitWith {
			[_mkr] remoteExec ["lmn_fnc_squadSpawn", 2]
		};
	} forEach allPlayers;

	sleep 5;
};