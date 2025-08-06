// Checks for nearby players then removes the AI and resets the trigger  
params ["_unit", "_trg"];

_grp = group _unit;
// Wait until players are no longer nearby 
while {alive _unit} do {
	sleep 10;
	_nearPlayers = 0;
	{
		_dist = _unit distance _x;
		if (_dist <= 200) then {
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