// Deactivates AI when no players are nearby. 
params ["_trg"];

// Get the spawned in units from the trigger 
_spawned = _trg getVariable ["SpawnedUnits", []];
{
	deleteVehicle _x;
} forEach _spawned;