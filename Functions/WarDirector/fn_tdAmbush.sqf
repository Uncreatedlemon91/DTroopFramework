// Tactical commander that directs an Ambush assault 
params ["_trig"];

// Gather forcepool data 
_troopCount = _trig getVariable "TroopCount";

// Decide how many forces to send / engage with
_troopsToSend = round (_troopCount * (0.3 + random 0.2));
