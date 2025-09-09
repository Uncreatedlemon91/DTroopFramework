// War Director is initialized. 
// Called from initServer.sqf

// Build initial database 
_wddb = ["NEW", format ["War Director %1 %2", missionName, worldName]] call OO_INIDBI;
_locDB = ["NEW", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Collect initial data and situation. 
_locations = "getSections" call _locDB;
_opforLocs = [];
_bluforLocs = [];
_opforMunitions = 0;
_bluforMunitions = 0;
_opforManpower = 0;
_bluforManpower = 0;
_opforFuel = 0;
_bluforFuel = 0;

{
	_name = ["read", _x, "Name"] call _locDB;
	_pos = ["read", _x, "Pos"] call _locDB;
	_resource = ["read", _x, "Resource"] call _locDB;
	_allegiance = ["read", _x, "Allegiance"] call _locDB;
	_priority = ["read", _x, "Priority"] call _locDB;
	_resourceQty = ["read", _x, "ResourceQty"] call _locDB;
	_data = [_name, _pos, _resource, _allegiance, _priority, _resourceQty];
	
	// Determine ownership & Resources
	if (_allegiance == "North") then {
		_opforLocs pushBack _x;
		switch (_resource) do {
			case "Munitions": {
				_opForMunitions = _opforMunitions + _resourceQty;
			};
			case "Manpower": {
				_opforManpower = _opforManpower + _resourceQty;
			};
			case "Fuel": {
				_opforFuel = _opforFuel + _resourceQty;
			};
		};
		// Save to WD Opfor 
		["write", ["Opfor", _x, _data]] call _wddb;
	} else {
		_bluforLocs pushBack _x;
		switch (_resource) do {
			case "Munitions": {
				_bluforMunitions = _bluforMunitions + _resourceQty;
			};
			case "Manpower": {
				_bluforManpower = _bluforManpower + _resourceQty;
			};
			case "Fuel": {
				_bluforFuel = _bluforFuel + _resourceQty;
			};
		};

		// Save to WD Blufor 
		["write", ["Blufor", _x, _data]] call _wddb;
	};
} forEach _locations;