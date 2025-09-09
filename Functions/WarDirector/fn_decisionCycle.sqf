// Creates a decision cycle for the War Director to run through every X seconds.
// Called from initServer.sqf after fn_wdStart.sqf

// Get the database 
_wddb = ["new", format ["War Director %1 %2", missionName, worldName]] call oo_inidbi;
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

while {true} do {
	// Cycle the locations, allowing the war director to determine it's actions 
	_locations = "getSections" call _wddb;
	{
		// Read the War director data 
		_data = ["read", [_x, "Location Info"]] call _wddb;
		_name = _data select 0;
		_pos = _data select 1;
		_resource = _data select 2;
		_allegiance = _data select 3;
		_priority = _data select 4;
		_resourceQty = _data select 5;
		
		// Get resources & Needs
		_munitions = 0;
		_manpower = 0;
		_fuel = 0;
		_needsGarrison = false;
		_needsAmbush = false;
		_needsAA = false;
		_needsMortar = false;
		_needsResource = false;

		if (_allegiance == "North") then {
			_munitions = ["read", ["Opfor-Resources", "Munitions"]] call _wddb;
			_manpower = ["read", ["Opfor-Resources", "Manpower"]] call _wddb;
			_fuel = ["read", ["Opfor-Resources", "Fuel"]] call _wddb;
		} else {
			_munitions = ["read", ["Blufor-Resources", "Munitions"]] call _wddb;
			_manpower = ["read", ["Blufor-Resources", "Manpower"]] call _wddb;
			_fuel = ["read", ["Blufor-Resources", "Fuel"]] call _wddb;
		};

		// Read the location data 
		_population = ["read", [_x, "Population"]] call _locDB;
		_ambushes = ["read", [_x, "AmbushCount"]] call _locDB;
		_aaSites = ["read", [_x, "AAsites"]] call _locDB;
		_garrisonSize = ["read", [_x, "GarrisonSize"]] call _locDB;
		_stability = ["read", [_x, "Stability"]] call _locDB;
		_mortarSites = ["read", [_x, "MortarSites"]] call _locDB;
		
		// Decision making process here
		switch (_priority) do {
			case 1 : {
				if (_garrisonSize < 3) then {
					_needsGarrison = true;
				};
				if (_ambushes < 2) then {
					_needsAmbush = true;
				};
				if (_aaSites < 2) then {
					_needsAA = true;
				};
				if (_mortarSites < 1) then {
					_needsMortar = true;
				};
				if (_resourceNeeded) then {
					_needsResource = true;
				};
			};
			case 2 : { };
			case 3 : { };
		};
	} forEach _locations;
};