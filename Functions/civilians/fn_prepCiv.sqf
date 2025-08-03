// Prepares the civilians triggers and movements to spawn in
params ["_trg"];
_loc = _trg getVariable "attachedLocation";
_pos = [[_trg]] call BIS_fnc_randomPos;

_mkr = createMarker [format ["%1-%2", _trg, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORGREEN";

_prep = createTrigger["EmptyDetector", _pos];
_prep setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_prep setTriggerArea [150, 150, 0, false, 200];
_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["Active", false];
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnCiv', 2]",
	""
];