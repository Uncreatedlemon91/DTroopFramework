// Sets a trigger to the battalion 
params ["_position", "_id", "_faction", "_mapMarker", "_name"];

// Create a trigger to represent the battalion on the map 
_trg = createTrigger ["EmptyDetector", _position];
_trg setTriggerArea [600, 600, 0, false, 200];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnBattalion', 2]",
	"thisTrigger setVariable ['TriggerActive', false, true]"
];

// Add variables to the trigger 
_trg setVariable ["lmnBattalionID", _id];
_trg setVariable ["lmnFaction", _faction];
_trg setVariable ["TriggerActive", false, true];
_trg setVariable ["ActiveGroups", [], true];
_trg setVariable ["lmnTrigPosture", "", true];

// Add a marker 
[_trg, _mapMarker, _name] spawn lmn_fnc_attachMarker;

// Return the trigger 
_trg;