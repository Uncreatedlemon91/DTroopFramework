// Create a grid on the map to determine control of the grids. 
_gridSize = 1000;
_mapSize = worldSize;

// Loop through the map's X-axis
for "_x" from 0 to (_mapSize / _gridSize) - 1 do {
    // Loop through the map's Y-axis
    for "_y" from 0 to (_mapSize / _gridSize) - 1 do {
        
        // Create a unique name for this grid square (e.g., "grid_5_12")
        _gridName = format ["grid_%1_%2", _x, _y];

        // Create a hashmap for this specific grid's data
        _gridData = createHashMap;
        
        // Set the default strategic values
		_controlScore = 0;
		_civilianPop = 0;
		_isSpawned = false;
		_centerPos = [(_x * _gridSize) + (_gridSize / 2), (_y * _gridSize) + (_gridSize / 2), 0];
		_opfor = [];
		_blufor = [];
		_indfor = [];
       
        // Save this grid's data into the master hashmap
        ["NEW", [format ["%1-%2-%3", _gridName, missionName, worldName]]] call oo_inidbi;


		// US/ARVN Control (Blue)
		if (_score > 10) then { _color = "ColorBlue"; };
		// VC/NVA Control (Red)
		if (_score < -10) then { _color = "ColorRed"; };
		// Contested (Yellow)
		if (_score >= -10 && _score <= 10) then { _color = "ColorYellow"; };

    };
};

// You now have a global variable, _mapGrid, that contains the entire strategic map!