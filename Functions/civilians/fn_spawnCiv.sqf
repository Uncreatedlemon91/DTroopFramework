// Spawns a civilian into the world 
params ["_trg"];

// Check if trigger is already active
_active = _trg getVariable "Active";
if (_active) exitwith {
	// Exit the code as the trigger is active already
	systemchat "Trigger already Active";
};

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get details about the location
_loc = _trg getVariable "attachedLocation";
_loyalty = ["read", [_loc, "Loyalty"]] call _locDB;

// Spawn the civilian 
_class = selectRandom (lmn_Civilians select 0);
_grp = createGroup Civilian;
_unit = _grp createUnit [_class, position _trg, [], 4, "FORM"];

// Give the civilian variables 
_unit setVariable ["loyalty", random [(_loyalty - 25), _loyalty, (_loyalty + 25)]];

// Give the civilian something to do 
_action = selectRandom lmn_civActions;
[_unit, _loc, _grp] remoteExec [_action, 2];

// Add the civilian to curator 
zeus addCuratorEditableObjects [[_unit], true];

// Check the nearby players to see if any are close to the unit
[_unit, _trg] remoteExec ["lmn_fnc_despawnAI", 2];

