// Prepares the trigger and information for an ambush 
params ["_loc", "_faction"];
_pos = position (selectRandom (nearestTerrainObjects [position _loc, ["ROAD", "TRAIL", "MAIN ROAD"], 800, false, false]));
_alpha = 0;

// Setup a Marker
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORRED";
_mkr setMarkerAlpha _alpha;

// Determine the ambush details 
switch (_faction) do {
	case "North": {_factionToSpawn = lmn_pavn};
	case "USA": {_factionToSpawn = lmn_US};
	default { };
};

// Make the unit
_infantrySize = random [3, 6, 10];
_reconSize = random [2, 4, 6];
_toSpawn = [];

from "_i" for _infantrySize do {
	_infantry = selectRandom (_factionToSpawn select 0);
	_toSpawn pushback _infantry;
};
for "_i" from 1 to _reconSize do {
	_recon = selectRandom (_factionToSpawn select 1);
	_toSpawn pushback _recon;
};

// Setup Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [250, 250, 0, false, 100];
_prep setTriggerInterval 5;
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnAmbush', 2]",
	""
];

_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["faction", _faction];
_prep setVariable ["Active", false];
_prep setVariable ["ToSpawn", _groupClass];
_prep setVariable ["FactionSide", _side];