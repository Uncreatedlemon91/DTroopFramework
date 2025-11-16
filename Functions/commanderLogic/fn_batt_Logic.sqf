// Provides the logic to the AI Battalions 
params ["_batt", "_trig"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

while {alive _trig} do {
	_name = ["read", [_batt, "name"]] call _db;
	_faction = ["read", [_batt, "Faction"]] call _db;
	_posture = ["read", [_batt, "Posture"]] call _db;
	_position = ["read", [_batt, "Position"]] call _db;
	_mapMarker = ["read", [_batt, "MapMarker"]] call _db;
	_dest = ["read", [_batt, "Destination", []]] call _db;
	
	// Calculate Variables 

	// Determine strength + Look for reinfocements 
	_need = [_batt] call lmn_fnc_batt_getStrength;
	if (_need != "Full Size") then {
		[_faction, _squad, _position, _mapMarker] remoteExec ["lmn_fnc_batt_getSupply", 2];
	};

	// If full health, and in reserves, move out. 
	if ((_posture == "Reserve") AND (count _needs == 0)) then {
		// Move to another location 
		_nearLoc = [_position, 2000, _faction] call lmn_fnc_getNearLocations;
		_newLocPos = _nearLoc select 0;
		_newLocPos = selectRandom _newLocPos;
		_newLocPos = _newLocPos select 1;
		[_trig, _newLocPos] remoteExec ["lmn_fnc_moveTrigger", 2];
		["write", [_batt, "Posture", "Moving"]] call _db;
		["write", [_batt, "Destination", _newLocPos]] call _db;
	};

	// Resume travels if posture is moving 
	if ((_posture == "Moving") AND ((_trig getVariable "lmnTrigPosture") != "Moving")) then {
		[_trig, _dest] remoteExec ["lmn_fnc_moveTrigger", 2];
	};

	// Send a patrol if stationary and 'Waiting'. 
	if (((_trig getVariable "lmnTrigPosture") == "Waiting") OR (_posture == "Patrol")) then {
		_squad = selectRandom _squads;
		["write", [_batt, "Posture", "Patrol"]] call _db;
		if ((_squad select 1) > 2) then {
			[_faction, _squad, _position, _mapMarker, _batt] remoteExec ["lmn_fnc_batt_getSupply", 2];
		};
	};

	// Sync Database 
	["write", [_batt, "Position", position _trig]] call _db;

	// Loop logic 
	sleep 60;
};