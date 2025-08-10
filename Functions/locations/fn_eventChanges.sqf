// Adapts the locations once every real time day. 
params ["_loc"];

// Get the Database Entry 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get the event current location 
_event = ["read", [_loc, "dayEvent"]] call _locDB;
_locFaction = ["read", [_loc, "Allegiance"]] call _locDB;

// Conclude the event's effects
_chanceToSucceed = selectRandomWeighted [true, 0.4, false, 0.6];

// Get the locations' nearby locations and their allegiance, priority and their events 
_nearLocs = nearestLocations [position _loc, [lmn_locations], 2000, true];
_enemyLocs = [];
_friendlyLocs = [];

{
	// Current result is saved in variable _x
	_faction = ["read", [_x, "Allegiance"]] call _locDB;
	if (_faction == _locFaction) then {
		_friendlyLocs pushback _x;
	} else {
		_enemyLocs pushback _x;
	};
} forEach _nearLocs;

// Logic to determine what a logical new event would be for this location 
_stance = "";
if ((count _enemyLocs) >= (count _friendlyLocs)) then {
	_stance = selectRandomWeighted ["Aggressive", 0.5, "Defensive", 0.4, "Guerilla", 0.3, "Build", 0.2];
} else {
	_stance = selectRandomWeighted ["Support", 0.4, "Defensive", 0.3, "Strike", 0.2, "Build", 0.2];
};

switch (_stance) do {
	case "Aggressive": {
		selectRandom [
			"Squad Probe",
			"Platoon Assault", 
			"Battalion Attack",
			"Recon Teams",
			"Insurgency"
		]
	};

	case "Defensive": {
		selectRandom [
			"New Patrol", 
			"Setup Defenses",
			"Build Traps", 
			"Hearts and Minds", 
			"Hunters"
		]
	};

	case "Guerilla": {
		selectRandom [
			"Hunters", 
			""
		]
	}
	default { };
};
// Save location to the database, will be triggered later on 
