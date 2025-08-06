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
_pos = position _trg;
_aa = [_pos, random 360, _groupClass, _side] call BIS_fnc_spawnVehicle;

{
	// Check for nearby players 
	[_x, _trg] remoteExec ["lmn_fnc_despawnAI", 2];
} forEach units _aa select 2;

// Give the unit orders to defend the point  
_grp setCombatMode "RED";
_trg setVariable ["Active", true];