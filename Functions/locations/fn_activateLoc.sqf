// Activated when players enter the trigger zone 
params ["_trg"];
_active = _trg getVariable "Active";
if (_active) exitwith {
	// Exit the code as the trigger is active already
	systemchat "Trigger already Active";
};
_trg setVariable ["Active", true];

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get details about the location
_loc = _trg getVariable "attachedLocation";
_stability = ["read", [_loc, "Stability"]] call _locDB;
_allegiance = ["read", [_loc, "Allegiance"]] call _locDB;
_priority = ["read", [_loc, "Priority"]] call _locDB;
_population = ["read", [_loc, "Population"]] call _locDB;
_ambushes = ["read", [_loc, "AmbushCount"]] call _locDB;

// Spawn civilians 
for "_i" from 1 to _population do {
	[_trg] remoteExec ["lmn_fnc_prepCiv", 2];
};

// Spawn ambush locations 
for "_i" from 1 to _ambushes do {
	[_trg, _allegiance] remoteExec ["lmn_fnc_prepAmbush", 2];
};