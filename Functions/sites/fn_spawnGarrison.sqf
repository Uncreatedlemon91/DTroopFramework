// Spawns an ambush for the player. 
params ["_trg"];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_active = _trg getVariable "Active";
_loc = _trg getVariable "attachedLocation";
_pos = position _trg;

// Check if trigger is already active 
if (_active) exitWith {};

// Make the unit  
_grp = [_pos, _side, _groupClass] call BIS_fnc_spawnGroup;

// Check for nearby players 
[leader _grp, _trg, "Garrison"] remoteExec ["lmn_fnc_despawnAI", 2];

// Give the unit orders to defend the point  
[_grp, _pos, 50] call lambs_wp_fnc_taskCamp;
_grp setSpeedMode "LIMITED";
_grp setCombatMode "BLUE"; 
_grp setBehaviour "SAFE";

_trg setVariable ["Active", true];
