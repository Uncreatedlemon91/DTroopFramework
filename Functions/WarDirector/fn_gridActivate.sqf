// Activates the grid when a player is active 
params ["_trg"];

// Set the marker alpha to 1 (fully visible) when activated
(_trg getVariable "gridMarker") setMarkerAlpha 1;
_trg setVariable ["gridActive", true, true];

hint format ["You entered grid: %1", _trg getVariable "gridCoords"];

systemChat format ["Spawning %1", _trg getVariable "gridForces"];

// Spawn the forces for this grid 
{
	_count = count _x;
	for "_i" from 1 to _count do
	{
		[_trg, _x] call lmn_fnc_gridSpawnForce;
	};
} forEach (_trg getVariable "gridForces");