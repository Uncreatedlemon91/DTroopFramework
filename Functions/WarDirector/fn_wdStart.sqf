// War Director is initialized. 
// Called from initServer.sqf
systemChat "War Director Initializing...";
// Build initial database 
_wddb = ["new", format ["War Director %1 %2", missionName, worldName]] call oo_inidbi;
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

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
	_name = ["read", [_x, "Name"]] call _locDB;
	_pos = ["read", [_x, "Pos"]] call _locDB;
	_resource = ["read", [_x, "Resource"]] call _locDB;
	_allegiance = ["read", [_x, "Allegiance"]] call _locDB;
	_priority = ["read", [_x, "Priority"]] call _locDB;
	_resourceQty = ["read", [_x, "ResourceQty"]] call _locDB;
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

// Save resources 
["write", ["Blufor-Resources", "Munitions", _bluforMunitions]] call _wddb;
["write", ["Blufor-Resources", "Manpower", _bluforManpower]] call _wddb;
["write", ["Blufor-Resources", "Fuel", _bluforFuel]] call _wddb;
["write", ["Opfor-Resources", "Munitions", _opforMunitions]] call _wddb;
["write", ["Opfor-Resources", "Manpower", _opforManpower]] call _wddb;
["write", ["Opfor-Resources", "Fuel", _opforFuel]] call _wddb;

// Debug chat 
systemChat "War Director Initialized";

// Start decision making logic 