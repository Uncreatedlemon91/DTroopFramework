// Spawns a civilian into the world 
params ["_trg"];

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get details about the location
_loc = _trg getVariable "attachedLocation";
_loyalty = ["read", [_loc, "Loyalty"]] call _locDB;

// Spawn the civilian 
_class = selectRandom (lmn_Civilians select 0);
_grp = createGroup Civilian;
_unit = _grp createUnit [_class, position _trg, [], 500, "FORM"];

// Give the civilian variables 
_unit setVariable ["loyalty", random [(_loyalty - 25), _loyalty, (_loyalty + 25)]];

// Give the civilian something to do 
_action = selectRandom lmn_civActions;
[_unit, _loc] remoteExec [_action, 2];

// Add the civilian to curator 
zeus addCuratorEditableObjects [[_unit], true];