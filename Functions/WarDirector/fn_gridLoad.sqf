// Get the database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _gridDB;

// --- CONFIGURATION ---
_gridSize = 500; // The size of each grid square in meters (width and height). 1000 = 1km.

{	
	// Read the grid data from the database
	_coords = ["read", [_x, "Coords"]] call _gridDB;
	_side = ["read", [_x, "Side"]] call _gridDB;
	_forcePower = ["read", [_x, "ForcePower"]] call _gridDB;
	_forces = ["read", [_x, "Forces"]] call _gridDB;
	_infrastructure = ["read", [_x, "Infrastructure"]] call _gridDB;
	_pos = ["read", [_x, "Position"]] call _gridDB;
	
	// Determine marker color
	_mkrColor = "";
	if (_side == "North") then {
		_mkrColor = "ColorRed";
	} else {
		_mkrColor = "ColorBlue";
	};
	
	// Create the trigger
	_trigger = createTrigger ["EmptyDetector", _pos, true]; // The 'false' makes it a local trigger, but it will be globalized via setVariable
	_trigger setTriggerArea [_gridSize * 1.2, _gridSize * 1.2, 0, true, 600];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trigger setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_gridActivate', 2]",
		"[thisTrigger] remoteExec ['lmn_fnc_gridDeactivate', 2]"
	];

	// Add a map marker 
	_mkr = createMarkerLocal [format ["Grid-%1", _coords], _pos];
	_mkr setMarkerShape "Rectangle";
	_mkr setMarkerSize [_gridSize / 2, _gridSize / 2];
	_mkr setMarkerColor _mkrColor;
	_mkr setMarkerAlpha 0.2;

	// Store the grid coordinates [x, y] on the trigger itself for easy identification
	_trigger setVariable ["gridCoords", _coords, true]; // 'true' makes this variable public/global
	_trigger setVariable ["gridSide", _side, true];
	_trigger setVariable ["gridMarker", _mkr, true];
	_trigger setVariable ["gridForces", _forces, true];
	_trigger setVariable ["gridInfrastructure", _infrastructure, true];
	_trigger setVariable ["gridForcePower", _forcePower, true]; // Random importance 1-10
	_trigger setVariable ["gridActive", false, true];
	_trigger setVariable ["gridActiveGroups", [], true];

	// Save the Trigger to the database 
	["write", [_x, "Trigger", netid _trigger]] call _gridDB;

	// Sleep to prevent script timeout on large maps
	sleep 0.01;
} forEach _sections;

// sleep to delay logic 
sleep 30;
systemChat "War Director starting...";
[] remoteExec ["lmn_fnc_wdTick", 2];