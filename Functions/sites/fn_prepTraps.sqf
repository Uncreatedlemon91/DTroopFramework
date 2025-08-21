// Prepares the site with traps and mines 
// Prepares the civilians triggers and movements to spawn in
params ["_loc", "_stability", "_locPos"];
_pos = [_locPos, 0, 500, 5, 0, 10, 0] call BIS_fnc_findSafePos;
_alpha = 0;

// Debug marker 
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORRED";
_mkr setMarkerAlpha _alpha;

// Create Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [50, 50, 0, false, 10];
_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["Activated", false, true];
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnTraps', 2]",
	"thisTrigger setVariable ['Activated', false]"
];

_prep setVariable ["ToSpawn", selectRandom [
	// Mines and Traps to be used
]];