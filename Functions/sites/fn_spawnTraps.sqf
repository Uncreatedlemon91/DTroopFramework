// Spawns the traps when players get close by
// Spawns an ambush for the player. 
params ["_trg"];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_active = _trg getVariable "Activated";
_loc = _trg getVariable "attachedLocation";

// Check if trigger is already active 
if (_active) exitWith {};

// change the activated flag 
_trg setVariable ["Activated", true, true];

// Make the unit  
_mine = createMine [_groupClass, position _trg, [], 0];

// Add to zeus 
zeus addCuratorEditableObjects [[_mine], true];

// Add an event handler for when the mine is triggered 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_currentCount = ["read", [_loc, "AAsites"]] call _locDB;
_newCount = _currentCount - 1;
_destroyed = true;
["write", [_loc, "AAsites", _newCount]] call _locDB;

while {_trg getVariable "Activated"} do {
	sleep 5;
};

// Despawn the AI when the trigger is no longer active
deleteVehicle _mine;