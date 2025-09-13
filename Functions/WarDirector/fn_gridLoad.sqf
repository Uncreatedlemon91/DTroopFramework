// Get the database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _gridDB;

// --- CONFIGURATION ---
_gridSize = 1000; // The size of each grid square in meters (width and height). 1000 = 1km.

{	
	// Load all grids from the database
	_coords = ["read", [_x, "gridCoords"]] call _gridDB;
	_side = ["read", [_x, "gridSide"]] call _gridDB;
	_imp = ["read", [_x, "gridImportance"]] call _gridDB;
	_forces = ["read", [_x, "gridForces"]] call _gridDB;
	_infra = ["read", [_x, "gridInfrastructure"]] call _gridDB;
	_pos = ["read", [_x, "gridPosition"]] call _gridDB;
	_mkrColor = "";

	// Determine marker color
	if (_side == "NORTH") then {
		_mkrColor = "ColorRed";
	} else {
		_mkrColor = "ColorBlue";
	};
	
	// Create the trigger
    _trigger = createTrigger ["EmptyDetector", _pos, true]; // The 'false' makes it a local trigger, but it will be globalized via setVariable
    _trigger setTriggerArea [_gridSize / 2, _gridSize / 2, 0, true, 600];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_trigger setTriggerStatements [
		"this", 
		"hint format ['You entered grid: %1', thisTrigger getVariable 'gridCoords']; (thisTrigger getVariable 'gridMarker') setMarkerAlpha 1;",
		""
	];

	// Add a map marker 
	_mkr = createMarkerLocal [format ["Grid-%1", _coords], _pos];
	_mkr setMarkerShape "Rectangle";
	_mkr setMarkerSize [_gridSize / 2, _gridSize / 2];
	_mkr setMarkerColor _mkrColor;
	_mkr setMarkerAlpha 0.4;

	// Store the grid coordinates [x, y] on the trigger itself for easy identification
	_trigger setVariable ["gridCoords", _coords, true]; // 'true' makes this variable public/global
	_trigger setVariable ["gridSide", _side, true];
	_trigger setVariable ["gridMarker", _mkr, true];
	_trigger setVariable ["gridForces", _forces, true];
	_trigger setVariable ["gridInfrastructure", _infra, true];
	_trigger setVariable ["gridImportance", _imp]; // Random importance 1-10

	// Add a map marker 
	_mkr2 = createMarkerLocal [format ["Grid-%1 Importance", _coords], _pos];
	_mkr2 setMarkerType "hd_dot";
	_mkr2 setMarkerText format ["Imp: %1", _trigger getVariable "gridImportance"];
	_mkr2 setMarkerSize [0.5, 0.5];
	_mkr2 setMarkerColor "COLORBLACK";

	// Sleep to prevent script timeout on large maps
	sleep 0.1;
} forEach _sections;

