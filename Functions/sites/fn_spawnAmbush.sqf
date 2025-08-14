// Spawns an ambush for the player. 
params ["_trg"];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_active = _trg getVariable "Active";
_loc = _trg getVariable "attachedLocation";

// Check if trigger is already active 
if (_active) exitWith {};

// Make the unit  
_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["TREE", "BUSH"], 50, false, false]));
_grp = [_pos, _side, _groupClass] call BIS_fnc_spawnGroup;

// Check for nearby players 
[leader _grp, _trg, "Ambush"] remoteExec ["lmn_fnc_despawnAI", 2];

// Give the unit orders to defend the point  
[_grp, 500] spawn lambs_wp_fnc_taskCreep;
_grp setCombatMode "RED";
_grp setBehaviour "SAFE";
_trg setVariable ["Active", true];