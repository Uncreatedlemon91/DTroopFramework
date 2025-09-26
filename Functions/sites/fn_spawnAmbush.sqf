// Spawns an ambush for the player. 
params ["_trg"];

// Check if trigger is already active
_active = _trg getVariable "Activated";
if (_active) exitwith {
	systemchat "[AMBUSH] Trigger already Active";
};

// change the activated flag 
_trg setVariable ["Activated", true, true];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_loc = _trg getVariable "attachedLocation";

// Spawn the unit 
_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["TREE", "BUSH"], 50, false, false]));
if (isnil "_pos") then {
	_pos = [position _trg, 0, 40, 5, 0, 10, 0] call BIS_fnc_findSafePos;
};
_pos = [_pos select 0, _pos select 1, 0];
_grp = createGroup _side;
_destroyed = false;
{
	// Current result is saved in variable _x
	_unit = _grp createUnit [_x, _pos, [], 15, "FORM"];
	_unit setVariable ["lambs_danger_dangerRadio", true];
	zeus addCuratorEditableObjects [[_unit], true];
	sleep 0.2;
} forEach _groupClass;

// Give the unit orders to defend the point 
_task = selectRandom ["creep", "hunt", "rush"];
switch (_task) do {
	case "creep": {[_grp, 500] spawn lambs_wp_fnc_taskCreep};
	case "hunt": {[_grp, 500] spawn lambs_wp_fnc_taskHunt};
	case "rush": {[_grp, 500] spawn lambs_wp_fnc_taskRush};
};
_grp setCombatMode "RED";
_grp setBehaviour "SAFE";
_grp deleteGroupWhenEmpty true;
_grp setVariable ["lambs_danger_enableGroupReinforce", true, true];

// Update the trigger to move with the unit leader 
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
	if ((_count <= 2) AND !(_destroyed == true)) then {
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_currentCount = ["read", [_loc, "AmbushCount"]] call _locDB;
		_newCount = _currentCount - 1;
		_destroyed = true;
		["write", [_loc, "AmbushCount", _newCount]] call _locDB;
	}
};

// Despawn the AI when the trigger is no longer active
{
	deleteVehicle _x;
	sleep 0.2;
} forEach units _grp;
deleteGroup _grp;