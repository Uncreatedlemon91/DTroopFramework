// Walks around the town, going to random houses and locations 
params ["_unit", "_loc"];

// Get a location to go to 
_targetPos = [[_loc], []] call BIS_fnc_randomPos;
[(group _unit), _targetPos] call BIS_fnc_taskDefend;

// Set unit parameters for the mission 
(group _unit) setSpeedMode "LIMITED";
