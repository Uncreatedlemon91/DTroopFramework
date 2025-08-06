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

{
	// Check for nearby players 
	[_x, _trg, "Ambush"] remoteExec ["lmn_fnc_despawnAI", 2];
} forEach units _grp;

// Give the unit orders to defend the point  
[_grp, position _trg] call BIS_fnc_taskDefend;
_grp setCombatMode "RED";
_trg setVariable ["Active", true];