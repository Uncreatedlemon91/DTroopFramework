// Provides the logic to the AI Battalions 
params ["_batt"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// SetVariables 
_name = ["read", [_batt, "name"]] call _db;
_faction = ["read", [_batt, "Faction"]] call _db;
_posture = ["read", [_batt, "Posture"]] call _db;
_comp = ["read", [_batt, "Composition"]] call _db;
_fullStrength = ["read", [_batt, "FullStrength"]] call _db;
_position = ["read", [_batt, "Position"]] call _db;
_mapMarker = ["read", [_batt, "MapMarker"]] call _db;

// Calculate Variables 
_battStrength = [_comp, _fullStrength] call lmn_fnc_batt_getStrength;
_needs = _battStrength select 0;
_squads = _battStrength select 1;

// Determine strength + Look for reinfocements 
if (count _needs > 0) then {
	systemChat format ["%1 is getting supplies!", _name];
	[_squads, _position, _mapMarker] remoteExec ["lmn_fnc_batt_getSupply", 2];
};

// Move to another location 
_nearLoc = [_position, 2000] call lmn_fnc_getNearLocations;
_newLocPos = _nearLoc select 1;
_newLoc = _nearLoc select 0;

_trig = nearestObject [_position, "EmptyDetector"];

//_trig = _position nearEntities ["EmptyDetector", 10];
[_trig, _newLocPos] remoteExec ["lmn_fnc_moveTrigger", 2];
systemChat format ["Battalion trigger %1", _trig];