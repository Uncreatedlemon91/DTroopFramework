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
_pos = position _trg;
_aa = [_pos, random 360, _groupClass, _side] call BIS_fnc_spawnVehicle;
_veh = _aa select 0;
_crew = _aa select 1;
_grp = _aa select 2;

// Add to zeus 
zeus addCuratorEditableObjects [[_veh], true];
{
	// Current result is saved in variable _x
	zeus addCuratorEditableObjects [[_x], true];
} forEach _crew;

// Give the unit orders to defend the point  
_grp setCombatMode "RED";
_grp deleteGroupWhenEmpty true;
_trg setVariable ["Active", true];
_destroyed = false;
[_veh] call lambs_wp_fnc_taskArtilleryRegister;
// [_grp] call lambs_wp_fnc_taskArtilleryRegister;

while {_trg getVariable "Activated"} do {
	sleep 1;
	_ldr = leader _grp;
	_trg setpos (getPos _ldr);
	_count = 0;
	{
		if (alive _x) then {
			_count = _count + 1;
		};
	} forEach units _grp;
	if ((_count == 0) AND !(_destroyed == true)) then {
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_currentCount = ["read", [_loc, "AAsites"]] call _locDB;
		_newCount = _currentCount - 1;
		_destroyed = true;
		["write", [_loc, "AAsites", _newCount]] call _locDB;
	}
};

// Despawn the AI when the trigger is no longer active
{
	deleteVehicle _x;
	sleep 0.2;
} forEach _crew;
deleteVehicle _veh;