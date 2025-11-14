// Provides the logic to the AI Battalions 
params ["_batt", "_trig"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

while {alive _trig} do {
	// SetVariables 
	_name = ["read", [_batt, "name"]] call _db;
	_faction = ["read", [_batt, "Faction"]] call _db;
	_posture = ["read", [_batt, "Posture"]] call _db;
	_comp = ["read", [_batt, "Composition"]] call _db;
	_fullStrength = ["read", [_batt, "FullStrength"]] call _db;
	_position = ["read", [_batt, "Position"]] call _db;
	_mapMarker = ["read", [_batt, "MapMarker"]] call _db;
	_dest = ["read", [_batt, "Destination", []]] call _db;

	// Calculate Variables 
	_battStrength = [_comp, _fullStrength] call lmn_fnc_batt_getStrength;
	_needs = _battStrength select 0;
	_squads = _battStrength select 1;

	// Determine strength + Look for reinfocements 
	if (count _needs > 0) then {
		_squad = "";
		if ("Infantry Squad" in _squads) then {
			_squad = "Infantry Squad";
		} else {
			_squad = selectRandom _squads;
		};
		systemChat format ["%1 is getting supplies!", _name];
		[_faction, _squad, _position, _mapMarker] remoteExec ["lmn_fnc_batt_getSupply", 2];
	};

	// If full health, and in reserves, move out. 
	if ((_posture == "Reserve") AND (count _needs == 0)) then {
		// Move to another location 
		_nearLoc = [_position, 2000] call lmn_fnc_getNearLocations;
		_newLocPos = _nearLoc select 1;
		_newLoc = _nearLoc select 0;
		[_trig, _newLocPos] remoteExec ["lmn_fnc_moveTrigger", 2];
		["write", [_batt, "Posture", "Moving"]] call _db;
		["write", [_batt, "Destination", _newLocPos]] call _db;
	};

	// Resume travels if posture is moving 
	if ((_posture == "Moving") AND ((_trig getVariable "lmnTrigPosture") != "Moving")) then {
		[_trig, _dest] remoteExec ["lmn_fnc_moveTrigger"];
	};

	// Send a patrol if stationary and 'on mission'. 
	if (_posture == "Mission") then {
		_squad = selectRandom _squads;
		if ((_squad select 1) > 2) then {
			[_squad, _position, _mapMarker] remoteExec ["lmn_fnc_batt_Patrol", 2];
		};
	};
	
	// Sync Database 
	["write", [_batt, "Position", position _trig]] call _db;

	// Loop logic 
	sleep 60;
};