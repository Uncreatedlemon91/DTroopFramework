// A tick / Script loop that adds the decision making logic to the war director and orders AI to move 
// around the map, attack objectives, defend areas, etc.

// Pull database 
_gridDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_grids = "getSections" call _gridDB;

// Main loop
{
	systemChat format ["Assessing %1", (["read", [_x, "Name"]] call _griddb)];

	// Define Variables to use in logic
	// _nearLocs = ["read", [_x, "NearLocations"]] call _gridDB;

	
	// Get nearby locations 
	_locs = nearestLocations [position _loc, [
		"NameLocal",
		"NameVillage",
		"Name",
		"VegetationBroadleaf",
		"Hill",
		"NameMarine",
		"ViewPoint",
		"Strategic",
		"NameCity",
		"Airport",
		"NameMarine",
		"StrongpointArea",
		"NameCityCapital"
	], 2000];
	_nearLocs = [];
	{
		_nearLocs pushback (str _x);
	} forEach _locs;
	_nearLocs deleteAt 0;
	["write", [_loc, "NearLocations", _nearLocs]] call _locDB;

	// Check current situation in the grid
	_orders = [_nearLocs, _x] call lmn_fnc_wdCheckLocs; 
	_target = _orders select 0;
	_order = _orders select 1;

	// Issue orders to forces in the grid
	switch (_order) do {
		case "attack": {
			// Update the database for the attack
			_attackingForceSize = random _currentgarrisonSize;
			_attacker = _x;
			_defender = _target
			systemChat format ["%1 is attacking %2", _attacker, _defender];
			// Create a battlezone
			["write", [_x, "dayEvent", "Attack"]] call _gridDB;
		};
		case "defend": {
			systemChat format ["Grid %1: Fortifying defenses!", _x];
			// Logic to fortify current position
			// [_x, _currentForces] call lmn_fnc_gridDefend;
			["write", [_x, "dayEvent", "Defend"]] call _gridDB;
		};
		case "reinforce": {
			systemChat format ["Grid %1: Calling reinforcements!", _x];
			// Logic to call in reinforcements
			[_x, _currentSide, _triggerPos] call lmn_fnc_prepGarrison;
			_newGarrisonSize = _currentgarrisonSize + 1;
			["write", [_x, "GarrisonSize", _newGarrisonSize]] call _gridDB;
			["write", [_x, "dayEvent", "Reinforce"]] call _gridDB;
		};
		case "build": {
			systemChat format ["Grid %1: Building infrastructure!", _x];
			// Logic to build or repair infrastructure
			// [_x, _currentInfrastructure] call lmn_fnc_gridBuild;
			["write", [_x, "dayEvent", "Build"]] call _gridDB;
		};
		case "probe": {
			systemChat format ["Grid %1: Probing enemy defenses!", _x];
			// Logic to send out reconnaissance or probing attacks
			// [_x, _currentForces] call lmn_fnc_gridProbe;
			["write", [_x, "dayEvent", "Probe"]] call _gridDB;
		};
		case "airAttack": {
			systemChat format ["Grid %1: Launching air attack!", _x];
			// Logic to call in air support
			// [_x, _currentSide] call lmn_fnc_gridAirAttack;
			["write", [_x, "dayEvent", "AirAttack"]] call _gridDB;
		};
		case "artillery": {
			systemChat format ["Grid %1: Bombarding enemy positions!", _x];
			// Logic to call in artillery support
			// [_x, _currentSide] call lmn_fnc_gridArtillery;
			["write", [_x, "dayEvent", "Artillery"]] call _gridDB;
		};
		case "hold": {
			systemChat format ["Grid %1: Holding position.", _x];
			// Logic to hold current position and maintain readiness
			// [_x, _currentForces] call lmn_fnc_gridHold;
			["write", [_x, "dayEvent", "Holding"]] call _gridDB;
		};
		default {
			systemChat format ["Grid %1: No action taken.", _x];
		};
	};
} forEach _grids;
