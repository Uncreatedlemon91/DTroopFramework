// Parameters for the trigger
params ["_position", "_squadToSend", "_veterancy", "_faction"];

// Create the trigger 
_trig = createTrigger ["EmptyDetector", _position];
_trig setTriggerArea [350, 350, 0, false, 300];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_squadSpawn', 2]",
	"[thistrigger] remoteExec ['lmn_fnc_squadDespawn', 2]"
];

// Create Variables 
_trig setVariable ["TriggerSquad", _squadToSend];
_trig setVariable ["TriggerActive", false];
_trig setVariable ["TriggerVeterancy", _veterancy];
_trig setVariable ["TriggerFaction", _faction];

// Return the trigger 
_trig;