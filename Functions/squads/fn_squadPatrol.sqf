// Function to run a patrol with the squad to improve local security for the faction. 
params ["_batt"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// Action variables 
_hasLowSecLocs = false;
_hasSquadsToSend = false;

// Determine the local areas' security 
_position = ["read", [_batt, "Position"]] call _db;
_faction = ["read", [_batt, "Faction"]] call _db;
_veterancy = ["read", [_batt, "Veterancy"]] call _db;
_nearLocs = [_position, 2000, _faction] call lmn_fnc_getNearLocations;
_targetLocs = _nearLocs select 4;
if ((count _targetLocs) < 1) then {
	_targetLocs = _nearLocs select 0;
};

if ((count _targetLocs) > 0) then {
	_hasLowSecLocs = true;
};

// Check the battalions' strength 
_forcesToSend = [];
_types = ["Infantry Squads", "Recon Squads", "Tank Squads", "Mechanized Squads"];
{
	_forceCount = ["read", [_batt, _x]] call _db;
	if (_forceCount > 1) then {
		_forcesToSend pushback _x;
	};
} forEach _types;
if ((count _forcesToSend) > 0) then {
	_hasSquadsToSend = true;
};

// Determine if the mission should be sent out 
if ((_hasSquadsToSend) AND (_hasLowSecLocs)) then {
	["write", [_batt, "ActiveMissions", (["read", [_batt, "ActiveMissions", 0]] call _db) + 1]] call _db;
	// Select the target location and get it's position 
	_targetLoc = selectRandom _targetLocs;
	_targetID = _targetLoc select 0;
	_targetPos = _targetLoc select 1;

	// Determine the squad to be sent on patrol 
	_squadToSend = selectRandom _forcesToSend;

	// Reduce the battalion by that force and update database
	/*
	_currentForceCount = ["read", [_batt, _squadToSend]] call _db;
	["write", [_batt, _squadToSend, _currentForceCount - 1]] call _db;
	_currentForceSize = ["read", [_batt, "CurrentForceSize"]] call _db;
	["write", [_batt, _squadToSend, _currentForceSize - 1]] call _db;
	*/

	// Create a squad trigger and attach marker 
	_trig = [_position, _squadToSend, _veterancy, _faction] call lmn_fnc_squadCreateTrigger;
	_markerType = ["read", [_batt, "MapMarker"]] call _db;
	[_trig, _markerType, format ["%1-Security Patrol", ["read", [_batt, "Name"]] call _db]] remoteExec ["lmn_fnc_attachMarker", 2]; 

	// Move the trigger 
	[_trig, _targetPos] remoteExec ["lmn_fnc_moveTrigger", 2];

	// Wait until the trigger is next to the location 
	while {(position _trig distance _targetPos) > 75} do {sleep 5};

	// Once arrived, delay while the unit conducts a patrol 
	_duration = round (random [5, 10, 15]); 
	systemChat "Conducting Patrol operations!";
	sleep (_duration * 60);

	// Once patrols are completed, return back to Battalion HQ 
	systemChat "Patrol is returning to HQ!";
	[_trig, _position] remoteExec ["lmn_fnc_moveTrigger", 2];

	// Wait until the unit re-arrives 
	while {(position _trig distance _position) > 75} do {sleep 5};

	// Readd the squad that was sent out 
	/*
	_currentSquadCount = ["read", [_batt, _squadToSend]] call _db;
	["write", [_batt, _squadToSend, _currentSquadCount + 1]] call _db;
	*/

	// Increase the security of the area 
	[_targetID, _faction, 5] call lmn_fnc_updateSecurity;

	// Decrease flag for how many active missions are up
	["write", [_batt, "ActiveMissions", (["read", [_batt, "ActiveMissions", 0]] call _db) - 1]] call _db;

	// Delete the Trigger 
	deleteVehicle _trig;
};

if !(_hasLowSecLocs) then {
	["write", [_batt, "Posture", "Reserve"]] call _db;
};