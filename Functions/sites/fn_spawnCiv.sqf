// Spawns a civilian into the world 
params ["_trg"];

// Check if trigger is already active
_active = _trg getVariable "Activated";
if (_active) exitwith {
	systemchat "[CIVILIAN] Trigger already Active";
};

// change the activated flag 
_trg setVariable ["Activated", true];

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get details about the location
_loc = _trg getVariable "attachedLocation";
_stability = ["read", [_loc, "Stability"]] call _locDB;

// Spawn the civilian 
_class = selectRandom (lmn_Civilians select 0);
_grp = createGroup Civilian;
_unit = _grp createUnit [_class, position _trg, [], 4, "FORM"];
_grp deleteGroupWhenEmpty true;

// Give the civilian variables 
_unit setVariable ["Stability", random [(_stability - 25), _stability, (_stability + 25)]];
_destroyed = false;

// Give the civilian something to do 
[(group _unit), position _unit, 50] call BIS_fnc_taskPatrol;
(group _unit) setSpeedMode "LIMITED";

// Add the civilian to curator 
zeus addCuratorEditableObjects [[_unit], true];

// Waiting until the trigger is no longer active, also update the trigger location
// systemChat "[CIVILIAN] Despawning AI";
while {_trg getVariable "Activated"} do {
	sleep 1;
	_trg setpos (getpos _unit);
	_count = 0;
	{
		if (alive _x) then {
			_count = _count + 1;
		};
	} forEach units _grp;
	if ((_count == 0) AND !(_destroyed == true)) then {
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_currentCount = ["read", [_loc, "Population"]] call _locDB;
		_newCount = _currentCount - 1;
		_destroyed = true;
		["write", [_loc, "Population", _newCount]] call _locDB;
	}
};

deleteVehicle _unit;
deleteGroup _grp;