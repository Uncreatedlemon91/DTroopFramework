// Get the database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _gridDB;

// --- CONFIGURATION ---
_gridSize = 250; // The size of each grid square in meters (width and height). 1000 = 1km.

{	
	// Load all grids from the database
	_data = ["read", [_x, "gridData"]] call _gridDB;
	systemchat format ["%1", _data];

	// _data structure: [coords, side, forcePower, forces, infrastructure, position]
	_coords = _data select 0;
	_side = _data select 1;
	_imp = _data select 2;
	_forces = _data select 3;
	_infra = _data select 4;
	_pos = _data select 5;
	
	// Determine marker color
	_mkrColor = "";
	if (_side == "North") then {
		_mkrColor = "ColorRed";
	} else {
		_mkrColor = "ColorBlue";
	};
	
	// Create the trigger
	_trigger = createTrigger ["EmptyDetector", _pos, true]; // The 'false' makes it a local trigger, but it will be globalized via setVariable
	_trigger setTriggerArea [_gridSize * 2, _gridSize * 2, 0, true, 600];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trigger setTriggerStatements [
		"this", 
		"[thisTrigger] call lmn_fnc_gridActivate",
		"[thisTrigger] call lmn_fnc_gridDeactivate"
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
	_trigger setVariable ["gridInfrastructure", _infra, true];
	_trigger setVariable ["gridForcePower", _imp, true]; // Random importance 1-10
	_trigger setVariable ["gridActive", false, true];

	// Sleep to prevent script timeout on large maps
	sleep 0.1;
} forEach _sections;

// sleep to delay logic 
sleep 30;
systemChat "War Director starting...";
[] remoteExec ["lmn_fnc_wdTick", 2];