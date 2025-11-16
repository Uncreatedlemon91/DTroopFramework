// Gets nearby locations and returns them 
params ["_position", "_radius", "_battFaction"];

// Rewrite to pull from database instead 
// Use Faction Key / HEAT key / Position Key
// Return the [Enemy, enemyHighHeat, Friendly, friendlyHighHeat, friendlyLowSecurity]
// Prioritize HEAT / Friendly Low Security / Location

// Get the database entries 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locdb;

// Get filter locations 
_friendlyLocs = [];
_hostileLocs = [];
_nearLowSec = [];
_nearHighHeat = [];

{
	// Current result is saved in variable _x
	_pos = ["read", [_x, "Position"]] call _locDb;
	if ((_pos distance _position) < _radius) then {
		// Nearby location, get the faction of it 
		_faction = ["read", [_x, "Faction"]] call _locDb;
		if (_faction == _battFaction) then {
			_friendlyLocs pushback [_x, _pos];
		} else {
			_hostileLocs pushback [_x, _pos];
		};

		// Find low security zones 
		_sec = ["read", [_x, "Security"]] call _locDb;
		if ((_sec < 50) OR (_sec > -50)) then {
			_nearLowSec pushback [_x, _pos];
		};

		// Find High Heat 
		_heat = ["read", [_x, "Heat Level"]] call _locDb;
		if (_heat > 0) then {
			_nearHighHeat pushback [_x, _pos];
		};
	};
} forEach _locs;

_data = [_friendlyLocs, _hostileLocs, _nearLowSec, _nearHighHeat];
_data;