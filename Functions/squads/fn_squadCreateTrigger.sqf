// Parameters for the trigger
params ["_position", "_squadToSend", "_veterancy"];

// Create the trigger 
_trig = createTrigger ["EmptyDetector", _position, true];
_trig setTriggerArea [350, 350, 0, false, 300];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_spawnSquad', 2]",
	"thisTrigger setVariable ['TriggerActive', false, true]"
];

// Create Variables 
_trig setVariable ["TriggerSquad", _squadToSend, true];
_trig setVariable ["TriggerActive", false, true];
_trig setVariable ["TriggerVeterancy", _veterancy, true];

// Return the trigger 
_trig;