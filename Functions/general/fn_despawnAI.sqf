// Checks for nearby players then removes the AI and resets the trigger  
params ["_unit", "_trg", "_type"];

_grp = group _unit;
_dist = 200;
switch (_type) do {
	case "Civilian": {_dist = 200};
	case "Ambush": {_dist = 300};
	case "AA": {_dist = 1300};
	case "Garrison": {_dist = 600};
};
// Wait until players are no longer nearby 
while {alive _unit} do {
	sleep 10;
	_nearPlayers = 0;
	{
		_distDiff = _unit distance _x;
		if (_distDiff <= _dist) then {
			_nearPlayers = _nearPlayers + 1;
		};
	} forEach allPlayers;

	if (_nearPlayers == 0) exitwith {
		deleteVehicle _unit;
		_groupCount = count (units _grp);
		if (_groupCount < 2) then {
			_vehs = [_grp, true] call BIS_fnc_groupVehicles;
			{
				deleteVehicle _x;
			} forEach _vehs;
			_trg setVariable ["Active", false];
		};
	};
};