// Provides the logic to the AI Battalion that is provided. 
// Loops function routinely in order to best preserve AI Commands. 
params ["_batt", "_trig"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

while {alive _trig} do {
	_posture = ["read", [_batt, "Posture"]] call _db;

	if (_posture == "In Mission") then {
		// Check if it needs supplies, if so, send out a patrol to gain supplies 
		[_batt] remoteExec ["lmn_fnc_squadGetSupply", 2];

		// Check nearby locations for patrol targets and send out patrols 
		// [_batt] remoteExec ["lmn_fnc_squadPatrol", 2];

		// Build up defenses in the area 
		// [_batt] remoteExec ["lmn_fnc_squadBuild", 2];

		// Send out Recon patrols 
		// [_batt] remoteExec ["lmn_fnc_squadRecon", 2];
	}:

	// Sync Database 
	["write", [_batt, "Position", position _trig]] call _db;

	// Loop logic 
	sleep 60;
};