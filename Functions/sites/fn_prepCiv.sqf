// Prepares the civilians triggers and movements to spawn in
params ["_loc"];
_pos = position (selectRandom (nearestTerrainObjects [position _loc, ["HOUSE"], 400]));
_alpha = 0;

// Debug marker 
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORGREEN";
_mkr setMarkerAlpha _alpha;

// Create Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [150, 150, 0, false, 200];
_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["Active", false];
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnCiv', 2]",
	"[thisTrigger] remoteExec ['lmn_fnc_DeactivateAI', 2]"
];