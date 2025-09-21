// Activates the grid when a player is active 
params ["_trg"];
_active = _trg getVariable "gridActive";

// Already active, do nothing
if (_active) exitWith {}; 

// Set the marker alpha to 1 (fully visible) when activated
(_trg getVariable "gridMarker") setMarkerAlpha 1;
_trg setVariable ["gridActive", true, true];

hint format ["You entered grid: %1", _trg getVariable "gridCoords"];

systemChat format ["%1", (_trg getVariable "gridForces")];
// Spawn the forces for this grid 
{
	[_trg, _x] remoteExec ["lmn_fnc_gridSpawnForces", 2];
} forEach (_trg getVariable "gridForces");