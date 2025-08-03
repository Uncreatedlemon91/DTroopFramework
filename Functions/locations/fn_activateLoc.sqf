// Activated when players enter the trigger zone 
params ["_trg"];

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get details about the location
_loc = _trg getVariable "attachedLocation";
_loyalty = ["read", [_loc, "Loyalty"]] call _locDB;
_allegiance = ["read", [_loc, "Allegiance"]] call _locDB;
_priority = ["read", [_loc, "Priority"]] call _locDB;
_population = ["read", [_loc, "Population"]] call _locDB;

// Spawn civilians 
for "_i" from 1 to _population do {
	[_trg] remoteExec ["lmn_fnc_prepCiv", 2];
	sleep 1;
};
