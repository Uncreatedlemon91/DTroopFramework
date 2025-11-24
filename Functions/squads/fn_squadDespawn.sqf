// Despawns spawned in squads 
params ["_trig"];

_activeGroups = _trig getVariable "ActiveGroups";

// Delete units
{
	// Current result is saved in variable _x
	_units = units _x;
	{
		// Current result is saved in variable _x
		_veh = vehicle _x;
		deleteVehicle _veh;
		deleteVehicle _x;
		sleep 0.03;
	} forEach _units;
} forEach _activeGroups;

_trig setVariable ["TriggerActive", false];