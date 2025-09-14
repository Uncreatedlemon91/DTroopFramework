// Deactivates the grid system when no players are active 
params ["_trg"];

// Set the marker alpha back to 0.4 (semi-transparent) when deactivated
(_trg getVariable "gridMarker") setMarkerAlpha 0.4;
_trg setVariable ["gridActive", false, true];
hint format ["You left grid: %1", _trg getVariable "gridCoords"];