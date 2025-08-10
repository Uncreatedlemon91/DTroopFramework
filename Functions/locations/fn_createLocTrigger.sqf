// Create a Trigger on the location 
params ["_loc"];

_trg = createTrigger ["EmptyDetector", position _loc];
_trg setTriggerArea [800, 800, 0, false, 200];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trg setVariable ["attachedLocation", _loc];
_trg setVariable ["Active", false];
_trg setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
	"thisTrigger setVariable ['Active', false]"
];