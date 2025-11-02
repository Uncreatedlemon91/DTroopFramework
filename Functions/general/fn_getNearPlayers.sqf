// Gets the nearby player from the unit 
params ["_unit"];

// find nearby player 
_nearPlayers = [];
{
	// Current result is saved in variable _x
	if ((position _unit distance _x) < 20) then {
		_nearPlayers pushBackUnique _x;
	};
} forEach allPlayers;

// Send back the array 
_nearPlayers;