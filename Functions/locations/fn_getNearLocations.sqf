// Gets nearby locations and returns them 
params ["_object"];

// Calculcate local positions 
_localPos = position _object;
_nearLocations = [];
{
	_locPos = position _x;
	_distance = _localPos distance _locPos;
	if (_distance < 5000 && _x != _object) then {
		_nearLocations pushBack _x;
	};
} forEach allLocations;

_nearLocations;