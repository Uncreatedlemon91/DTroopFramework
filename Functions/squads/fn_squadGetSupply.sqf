// Function for a squad to collect supplies from a nearby location to reinforce it's battalion. 
params ["_batt"];

// Get the Database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// Create variable that will be returned 
_needsReinforcement = false;
_hasSquadsToSend = false;

// Determine if the Battalion needs supply or not 
_currentForceSize = ["read", [_batt, "CurrentForceSize"]] call _db;
_maxForceSize = ["read", [_batt, "MaxForceSize"]] call _db;
_newSquadType = "";
if (_currentForceSize < _maxForceSize) then {
	// Select a squad based on the type of battalion it is 
	_needsReinforcement = true;
	_battType = ["read", [_batt, "Type"]] call _db;
	_newSquadType = "";
	switch (_battType) do {
		case "Infantry": {_newSquadType = selectRandomWeighted ["Infantry Squads", 0.6, "Recon Squads", 0.2, "Mortar Squads", 0.1]};
		case "Special Forces": {_newSquadType = selectRandomWeighted ["Infantry Squads", 0.4, "Recon Squads", 0.4, "Mortar Squads", 0.2]};
		case "Armor": {_newSquadType = selectRandomWeighted ["Infantry Squads", 0.3, "Tank Squads", 0.3, "Recon Squads", 0.2, "Mechanized Squads", 0.3]};
	};
};

// Check if we have a spare infantry squad available 
_infantrySquads = ["read", [_batt, "Infantry Squads"]] call _db;
_mechanizedSquads = ["read", [_batt, "Mechanized Squads"]] call _db;
_squadToSend = "";
if ((_infantrySquads > 0) OR (_mechanizedSquads > 0)) then {
	// We can go on a mission to get supply! 
	_hasSquadsToSend = true;
	if (_infantrySquads > _mechanizedSquads) then {
		_squadToSend = "Infantry Squads";
	} else {
		_squadToSend = "Mechanized Squads";
	};
};

// Final check to run the mission or not
if ((_needsReinforcement) AND (_hasSquadsToSend)) then {
	// Execute the mission 
	_battHQ = ["read", [_batt, "Position"]] call _db;
	_faction = ["read", [_batt, "Faction"]] call _db;
	_nearLocs = [_battHQ, 1500, _faction] call lmn_fnc_getNearLocations;
	_friendlyLocs = _nearLocs select 0;
	_selectedLoc = selectRandom _friendlyLocs;
	_locPos = _selectedLoc select 1;

	// Remove a squad from battalion force pool 
	_currentSquadCount = ["read", [_batt, _squadToSend]] call _db;
	["write", [_batt, _squadToSend, _currentSquadCount - 1]] call _db;
	
	// Create a trigger for the squad 
	_trig = createTrigger ["EmptyDetector", _battHQ, true];
	_trig setTriggerArea [350, 350, 0, false, 300];
	_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trig setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_spawnSquad', 2]",
		"thisTrigger setVariable ['lmn_TrigActive', false, true]"
	];

	// Set Trigger Variables 
	_trig setVariable ["TriggerSquad", _squadToSend];
	_trig setVariable ["lmn_TrigActive", false, true];

	// Move the trigger to supply area 
	[_trig, _locPos] remoteExec ["lmn_fnc_moveTrigger", 2];

	// Attach a marker 
	_markerType = ["read", [_batt, "MapMarker"]] call _Db;
	[_trig, _markerType, format ["%1-Supply Retrieval"]] remoteExec ["lmn_fnc_attachMarker", 2];

	// Wait until the trigger is near to the destination 
	// waitUntil {sleep 5; (position _trig distance _locPos) < 75};
	while {(position _trig distance _locPos) > 75} do {sleep 5};

	// Once arrived, remain on station for a while , remove supply from the location 
	systemChat "Getting Supplies";
	_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	_supply = ["read", [_selectedLoc select 0, "Supply"]] call _locDB;
	if (_supply > 25) then {
		_newSupply = _supply - 25;
		["write", [_selectedLoc select 0, "Supply", _newSupply]] call _locDB;
	};
	_gatheredSupplies = true;
	// sleep (60 * 5);
	sleep 10;
	systemChat "On way back!";

	// Start journey back to the Batt HQ 
	[_trig, _battHQ] remoteExec ["lmn_fnc_moveTrigger", 2];

	// Wait until the trigger is back to Battalion HQ 
	while {(position _trig distance _battHQ) > 75} do {sleep 5};

	// Arrival back at HQ 
	// Check if mission was success, if so, increase force pool 
	if (_gatheredSupplies) then {
		_currentForce = ["read", [_batt, _newSquadType]] call _db;
		_currentForceSize = ["read", [_batt, "CurrentForceSize"]] call _db;
		_newForce = _currentForce + 1; 
		_newForceSize = _currentForceSize + 1;
		["write", [_batt, _newSquadType, _newForce]] call _db;
		["write", [_batt, "CurrentForceSize", _newForceSize]] call _db;
	};

	// Re-add the squad tasked with the role to the battalion orbat
	_currentSquadCount = ["read", [_batt, _squadToSend]] call _db;
	["write", [_batt, _squadToSend, _currentSquadCount + 1]] call _db;

	// Dismiss the trigger and marker 
	deleteVehicle _trig;
};

