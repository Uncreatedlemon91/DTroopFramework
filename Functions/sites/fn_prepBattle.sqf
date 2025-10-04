// Prepares a battle scene 
params ["_attacker", "_defender", "_battlePos"];

// Setup a Marker
_mkr = createMarker [format ["Battlezone-%1", _battlePos], _battlePos];
_mkr setMarkerShape "ELLIPSE";
_mkr setMarkerSize [1000, 1000];
_mkr setMarkerColor "COLORBLACK";
_mkr setMarkerAlpha 0.5;

// Create the battle scene 
