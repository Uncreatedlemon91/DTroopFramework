// Parameters for the trigger
params ["_position", "_squadToSend"];

// Create the trigger 
_trig = createTrigger ["EmptyDetector", _position, true];
_trig setTriggerArea [350, 350, 0, false, 300];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_spawnSquad', 2]",
	"thisTrigger setVariable ['lmn_TrigActive', false, true]"
];

// Create Variables 
_trig setVariable ["TriggerSquad", _squadToSend, true];
_trig setVariable ["lmn_TrigActive", false, true];

// Return the trigger 
_trig;