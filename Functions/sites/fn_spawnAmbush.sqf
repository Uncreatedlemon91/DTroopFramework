// Spawns an ambush for the player. 
params ["_trg"];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_active = triggerActivated _trg;
_loc = _trg getVariable "attachedLocation";

// Check if trigger is already active 
if (_active) exitWith {};

// Spawn the unit 
_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["TREE", "BUSH"], 50, false, false]));
_grp = createGroup _side;

// Give the unit orders to defend the point  
[_grp, 500] spawn lambs_wp_fnc_taskCreep;
_grp setCombatMode "RED";
_grp setBehaviour "SAFE";
_trg setVariable ["Active", true];

// Update the trigger to move with the unit leader 
_active = triggerActivated _trg;
while {_active} do {
	_active = triggerActivated _trg;
	_ldr = leader _grp;
	_trg setpos _ldr;
	sleep 5;
};

// Despawn the AI when the trigger is no longer active
{
	deleteVehicle _x;
} forEach units _grp;