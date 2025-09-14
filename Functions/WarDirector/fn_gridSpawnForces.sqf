// Spawns the AI forces in the area when the grid is activated
params ["_trg", "_type"];

// Create the group
_grp = createGroup (_trg getVariable "gridSide");

{
	// Current result is saved in variable _x
	_unit = createUnit [_x, position _trg, _grp, "", 0, "FORM"];
	
} forEach _type;