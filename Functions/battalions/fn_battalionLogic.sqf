// Provides the logic to the AI Battalion that is provided. 
// Loops function routinely in order to best preserve AI Commands. 
params ["_batt", "_trig", "_faction"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

while {alive _trig} do {
	_posture = ["read", [_batt, "Posture"]] call _db;
	_activeMissions = ["read", [_batt, "ActiveMissions", 0]] call _db;

	if ((_posture == "Operational") AND (_activeMissions < 3)) then {
		// Check if it needs supplies, if so, send out a patrol to gain supplies 
		[_batt] remoteExec ["lmn_fnc_squadGetSupply", 2];

		// Check nearby locations for patrol targets and send out patrols 
		[_batt] remoteExec ["lmn_fnc_squadPatrol", 2];

		// Build up defenses in the area 
		// [_batt] remoteExec ["lmn_fnc_squadBuild", 2];

		// Send out Recon patrols 
		// [_batt] remoteExec ["lmn_fnc_squadRecon", 2];
	};

	if (_posture == "Reserve") then {
		// Moves the battalion to a frontline location. Small chance to maintain Reserve Status
		_locs = [position _trig, 2000, _faction] call lmn_fnc_getNearLocations;
		_loc = _locs select 0;
		_selLoc = selectRandom _loc;
		_locPos = _selLoc select 1;
		[_trig, _locPos] remoteExec ["lmn_fnc_moveTrigger", 2];

		// Wait until it arrives
		while {position _trig distance _locPos > 100} do {sleep 5};
		["write", [_batt, "Posture", "Operational"]] call _db;
	};

	if (_posture == "Desperate") then {
		// Evacuate the battalion with helicopters. Loses all Armored and Mortar assets. 
	};

	// Sync Database 
	["write", [_batt, "Position", position _trig]] call _db;

	// Loop logic 
	sleep 60;
};