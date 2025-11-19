// Gets nearby locations and returns them 
params ["_position", "_radius", "_battFaction"];

// Get the database entries 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locdb;

// Get filter locations 
_friendlyLocs = [];
_hostileLocs = [];
_nearLowSec = [];
_nearHighHeat = [];
_friendlyLowSec =[];

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

		// Find friendly locations with low sec 
		if ((_sec < _lowSec) AND (_faction == _battFaction)) then {
			_friendlyLowSec pushback [_x, _pos];
		};

		// Find High Heat 
		_heat = ["read", [_x, "Heat Level"]] call _locDb;
		if (_heat > 0) then {
			_nearHighHeat pushback [_x, _pos];
		};
	};
} forEach _locs;

// Clean up data
_friendlyLocs deleteAt 0;

// Export Data 
_data = [_friendlyLocs, _hostileLocs, _nearLowSec, _nearHighHeat, _friendlyLowSec];
_data;