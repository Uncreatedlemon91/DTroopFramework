// Prepares the trigger and information for an ambush 
params ["_trg", "_faction"];
_loc = _trg getVariable "attachedLocation";
_pos = position (selectRandom (nearestTerrainObjects [_trg, ["ROAD", "TRAIL", "MAIN ROAD"], 500, false, false]));

_mkr = createMarker [format ["%1-%2", _trg, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORRED";

_prep = createTrigger["EmptyDetector", _pos];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [150, 150, 0, false, 200];
_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["faction", _faction];
_prep setVariable ["Active", false];
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnAmbush', 2]",
	""
];