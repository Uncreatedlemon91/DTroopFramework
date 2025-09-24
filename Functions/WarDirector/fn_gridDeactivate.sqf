// Deactivates the grid system when no players are active 
params ["_trg"];
sleep 5;

// Get Variables 
_db = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_coords = _trg getVariable "gridCoords";

// Set the marker alpha back to 0.2 (semi-transparent) when deactivated
(_trg getVariable "gridMarker") setMarkerAlpha 0.2;
_trg setVariable ["gridActive", false, true];
hint format ["You left grid: %1", _trg getVariable "gridCoords"];

// Deactivate forces in the area 
_activeGroups = _trg getVariable ["gridActiveGroups", []];
_forces = [];
_savedForces = ["read", [_coords, "gridForces"]];
{
	{
		deleteVehicle vehicle _x;
		deleteVehicle (assignedVehicle _x);
		deleteVehicle _x;
	} forEach units _x;
	_type = _x getVariable "groupType";
	_forces pushback _type;
} forEach _activeGroups;

{
	
	
} forEach _savedForces;

["write", [_coords, "Forces", _forces]] call _db;