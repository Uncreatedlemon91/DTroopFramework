// Despawns the AI Ambush locations 
params ["_trg"];

// Get all units that are in the trigger zone still 
_unitsInTriggerArea = allUnits inAreaArray _trg;
{
	// Current result is saved in variable _x
	deleteVehicle _x;
} forEach _unitsInTriggerArea;
