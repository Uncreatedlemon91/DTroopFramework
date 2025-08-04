// Checks for nearby players then removes the AI and resets the trigger  
params ["_unit", "_trg"];

// Wait until players are no longer nearby 
while {alive _unit} do {
	sleep 5;
	_nearPlayers = 0;
	{
		_dist = _unit distance _x;
		if (_dist <= 200) then {
			_nearPlayers = _nearPlayers + 1;
		};
	} forEach allPlayers;

	if (_nearPlayers == 0) exitwith {
		deleteVehicle _unit;
		_trg setVariable ["Active", false];
	};
};