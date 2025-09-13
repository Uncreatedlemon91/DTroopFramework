/*
    File: createGrid.sqf
    Author: Coding Partner
    Description: Creates a grid of triggers across the entire map.
*/

// --- CONFIGURATION ---
_gridSize = 500; // The size of each grid square in meters (width and height). 1000 = 1km.

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
for "_y" from 1 to _gridCountY do {
    for "_x" from 1 to _gridCountX do {
        // Calculate the center position for the new trigger
        _posX = (_x * _gridSize) + (_gridSize / 2);
        _posY = (_y * _gridSize) + (_gridSize / 2);
        _triggerPos = [_posX, _posY, 0];
        
        // Create the trigger
        _trigger = createTrigger ["EmptyDetector", _triggerPos, false]; // The 'false' makes it a local trigger, but it will be globalized via setVariable
        
		// Determine trigger side
		_mkrColor = ""; 
		if (_triggerPos inArea "SouthAO") then {
			_side = selectRandomWeighted ["USA", 0.3, "ROK", 0.5, "AUS", 0.2, "NZ", 0.1];
			_mkrColor = "ColorBlue";
		} else {
			_side = "NORTH";
			_mkrColor = "ColorRed";
		};

        // Set the trigger area (a square)
        // setTriggerArea [a, b, angle, isRectangle, c]
        // For a square, 'a' and 'b' are half the width/height. 'isRectangle' is false.
        _trigger setTriggerArea [_gridSize * 2, _gridSize * 2, 0, true, 600];
        
        // Set basic trigger activation properties (example)
        // This example activates for any player, once, when present.
        // You can change this to suit your needs.
        _trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];

		// Add a map marker 
		_mkr = createMarkerLocal [format ["Grid-%1-%2", _x, _y], _triggerPos];
		_mkr setMarkerShape "Rectangle";
		_mkr setMarkerSize [_gridSize / 2, _gridSize / 2];
		_mkr setMarkerColor _mkrColor;
		_mkr setMarkerAlpha 0.4;
        
        // Store the grid coordinates [x, y] on the trigger itself for easy identification
        _trigger setVariable ["gridCoords", [_x, _y], true]; // 'true' makes this variable public/global
        _trigger setVariable ["gridFaction", _side];
		_trigger setVariable ["gridMarker", _mkr];
		_trigger setVariable ["gridForces", []];
		_trigger setVariable ["gridInfrastructure", []];
		_trigger setVariable ["gridImportance", round (random 9) + 1];

        // Add an example statement to show it's working.
        // This will hint the coordinates to the player who activates it.
        // REMOVE or CHANGE this for your actual mission!
        _trigger setTriggerStatements [
			"this", 
			"hint format ['You entered grid: %1', thisTrigger getVariable 'gridCoords']; (thisTrigger getVariable 'gridMarker') setMarkerAlpha 1;",
			""
		];

        // Add the newly created trigger to our global array
        _GRID_TRIGGERS pushBack _trigger;
    };
};

// Log the completion and total number of triggers created
diag_log format ["[GRID] Finished creating %1 triggers.", count _GRID_TRIGGERS];