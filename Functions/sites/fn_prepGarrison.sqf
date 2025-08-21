// Sets up a garrison site at a building 
params ["_loc", "_faction", "_locPos"];
_pos = [_locPos, 0, 600, 5, 0, 10, 0] call BIS_fnc_findSafePos;
_alpha = 0;

// Setup a Marker
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORBLACK";
_mkr setMarkerAlpha _alpha;

// Determine the Garrison details 
_side = west;
_factionToSpawn = "";
switch (_faction) do {
	case "North": {_factionToSpawn = lmn_pavn; _side = east};
	case "USA": {_factionToSpawn = lmn_US};
	case "ROK": {_factionToSpawn = lmn_ROK};
	case "AUS": {_factionToSpawn = lmn_AUS};
	case "NZ": {_factionToSpawn = lmn_NZ};
};

// Make the unit
_infantrySize = random [10, 15, 20];
_toSpawn = [];

for "_i" from 1 to _infantrySize do {
	_infantry = selectRandom (_factionToSpawn select 0);
	_toSpawn pushback _infantry;
};

// Setup Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [500, 500, 0, false, 300];
_prep setTriggerInterval 1;
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnGarrison', 2]",
	"thisTrigger setVariable ['Activated', false]"
];

_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["faction", _faction];
_prep setVariable ["Activated", false];
_prep setVariable ["ToSpawn", _toSpawn];
_prep setVariable ["FactionSide", _side];
