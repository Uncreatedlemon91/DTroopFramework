// Deactivates the grid system when no players are active 
params ["_trg"];
sleep 5;

// Set the marker alpha back to 0.2 (semi-transparent) when deactivated
(_trg getVariable "gridMarker") setMarkerAlpha 0.2;
_trg setVariable ["gridActive", false, true];
hint format ["You left grid: %1", _trg getVariable "gridCoords"];

// Deactivate forces in the area 
_activeGroups = _trg getVariable ["gridActiveGroups", []];
{
	{
		deleteVehicle vehicle _x;
		deleteVehicle (assignedVehicle _x);
		deleteVehicle _x;
	} forEach units _x;
} forEach _activeGroups;