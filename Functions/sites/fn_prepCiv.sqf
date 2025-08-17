// Prepares the civilians triggers and movements to spawn in
params ["_loc", "_stability", "_locPos"];
_pos = position (selectRandom (nearestTerrainObjects [_locPos, ["HOUSE"], 400]));
if (isnil "_pos") then {
	_pos = [_locPos, 0, 20, 5, 0, 10, 0] call BIS_fnc_findSafePos;
};
_alpha = 0.5;

// Debug marker 
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORGREEN";
_mkr setMarkerAlpha _alpha;

// Create Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [150, 150, 0, false, 300];
_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["Activated", false, true];
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnCiv', 2]",
	"thisTrigger setVariable ['Activated', false]"
];