// --- CONFIGURATION ---
_gridSize = 250; // The size of each grid square in meters (width and height). 1000 = 1km.

// Database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;

// --- SCRIPT LOGIC (Do not edit below) ---

// Log the start of the script
diag_log format ["[GRID] Starting trigger grid creation with size %1m.", _gridSize];

// Initialize a global array to hold all trigger objects for later reference
_GRID_TRIGGERS = [];

// Get the total map size
_mapSize = worldSize;

// Calculate the number of grids needed for each axis
_gridCountX = ceil (_mapSize / _gridSize);
_gridCountY = ceil (_mapSize / _gridSize);	

// Use nested loops to iterate over the map and create triggers
for "_y" from 0 to (_gridCountY - 1) do {
    for "_x" from 0 to (_gridCountX -1) do {
        // Calculate the center position for the new trigger
        _posX = (_x * _gridSize) + (_gridSize / 2);
        _posY = (_y * _gridSize) + (_gridSize / 2);
        _triggerPos = [_posX, _posY, 0];

		if (surfaceIsWater _triggerPos) then {} else {
			// Create the trigger
			_trigger = createTrigger ["EmptyDetector", _triggerPos, true]; // The 'false' makes it a local trigger, but it will be globalized via setVariable
			
			// Determine trigger side
			_mkrColor = ""; 
			_side = "";
			if ((_triggerPos inArea "SouthAO") OR (_triggerPos inArea "Base")) then {
				_side = "South";
				_mkrColor = "ColorBlue";
			} else {
				_side = "North";
				_mkrColor = "ColorRed";
			};

			// Set the trigger area (a square)
			// setTriggerArea [a, b, angle, isRectangle, c]
			// For a square, 'a' and 'b' are half the width/height. 'isRectangle' is false.
			_trigger setTriggerArea [_gridSize * 2, _gridSize * 2, 0, true, 600];
			
			// Set basic trigger activation properties (example)
			// This example activates for any player, once, when present.
			// You can change this to suit your needs.
			_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];

			// Add a map marker 
			_mkr = createMarkerLocal [format ["Grid-%1-%2", _x, _y], _triggerPos];
			_mkr setMarkerShape "Rectangle";
			_mkr setMarkerSize [_gridSize / 2, _gridSize / 2];
			_mkr setMarkerColor _mkrColor;
			_mkr setMarkerAlpha 0.2;

			// Variables Prep 
			_coords = [_x, _y];
			_forces = [];
			_infrastructure = [];
			_forcePower = 1;
			
			// Store the grid coordinates [x, y] on the trigger itself for easy identification
			_trigger setVariable ["gridCoords", [_x, _y], true]; // 'true' makes this variable public/global
			_trigger setVariable ["gridSide", _side, true];
			_trigger setVariable ["gridMarker", _mkr, true];
			_trigger setVariable ["gridForces", _forces, true];
			_trigger setVariable ["gridInfrastructure", _infrastructure, true];
			_trigger setVariable ["gridForcePower", _forcePower, true];
			_trigger setVariable ["gridActive", false, true];

			// Add an example statement to show it's working.
			// This will hint the coordinates to the player who activates it.
			// REMOVE or CHANGE this for your actual mission!
			_trigger setTriggerStatements [
				"this", 
				"[thisTrigger] call lmn_fnc_gridActivate",
				"[thisTrigger] call lmn_fnc_gridDeactivate"
			];

			// Add the newly created trigger to our global array
			_GRID_TRIGGERS pushBack _trigger;

			// Save to database
			["write", [format ["Grid-%1-%2", _x, _y], "Coords", _coords]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "Side", _side]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "ForcePower", _forcePower]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "Forces", _forces]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "Infrastructure", _infrastructure]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "Position", _triggerPos]] call _gridDB;
			["write", [format ["Grid-%1-%2", _x, _y], "Trigger", netid _trigger]] call _gridDB;
		};
	};
	// loop delay to prevent script timeout on large maps
	sleep 0.1;
};

// Log the completion and total number of triggers created
systemChat format ["[GRID] Finished creating %1 triggers.", count _GRID_TRIGGERS];
// sleep to delay logic 
sleep 30;
systemChat "War Director starting...";
[] remoteExec ["lmn_fnc_wdTick", 2];