// Orders an Infantry squad to go to a nearby location in order to get supplies
params ["_faction", "_squad", "_position", "_markerType"];

// Select a nearby location to get supply 
_nearLoc = [_position, 1000, _faction] call lmn_fnc_getNearLocations;
_loc = _nearLoc select 0;
_dest = _nearLoc select 1;

// Setup a virtual instance of the troop 
_trig = createTrigger ["EmptyDetector", _position, true];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerArea [250, 250, 0, false, 200];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_spawnSquad', 2]",
	"thisTrigger setVariable ['lmn_TrigActive', false]"
];

// Setup Trigger Variables 
_trig setVariable ["lmn_TrigSquad", _squad];
_trig setVariable ["lmn_TrigActive", false];
_trig setVariable ["lmn_TrigDest", _dest];

// Attach a marker to the trigger 
[_trig, _markerType, "Supply Mission"] spawn lmn_fnc_attachMarker;

// Move the trigger over time to the destination 
[_trig, _dest] remoteExec ["lmn_fnc_moveTrigger", 2];
