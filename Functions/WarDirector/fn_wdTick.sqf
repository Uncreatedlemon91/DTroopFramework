// A tick / Script loop that adds the decision making logic to the war director and orders AI to move 
// around the map, attack objectives, defend areas, etc.

// Pull database 
_gridDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_grids = "getSections" call _gridDB;

// Main loop
{
	systemChat format ["Assessing %1", (["read", [_x, "Name"]] call _griddb)];

	// Define Variables to use in logic
	_attack = 0;
	_reinforce = 0;
	_build = 0;
	_transfer = 0;
	_probe = 0;

	_nearLocs = ["read", [_x, "NearLocations"]] call _gridDB;
	_allegiance = ["read", [_x, "Allegiance"]] call _gridDB;
	_triggerPos = ["read", [_x, "Pos"]] call _gridDB;

	// Assess the area and determine possible actions
	_score = [_nearLocs, _x] call lmn_fnc_wdCheckLocs;
	// systemChat format ["%1", _score];

	// Issue the orders 
	_target = _score select 0;
	_order = _score select 1;

	// Issue orders to forces in the grid
	switch (_order) do {
		case "attack": {
			// Update the database for the attack
			["write", [_x, "dayEvent", "Attack"]] call _gridDB;
		};
		case "defend": {
			systemChat format ["Grid %1: Fortifying defenses!", _x];
			// Logic to fortify current position
			// [_x, _currentForces] call lmn_fnc_gridDefend;
			["write", [_x, "dayEvent", "Defend"]] call _gridDB;
		};
		case "reinforce": {
			// Logic to call in reinforcements
			_reinforceType = selectRandom ["Garrison", "Ambush", "AA", "Artillery"];
			switch (_reinforceType) do {
				case "Garrison": {
					// Setup Logic Variables 
					_current = ["read", [_x, "GarrisonSize"]] call _gridDB;

					// Add the new Garrison to the area
					[_x, _allegiance, _triggerPos] call lmn_fnc_prepGarrison;
					_newCount = _current + 1;

					// Update the database
					["write", [_x, "GarrisonSize", _newCount]] call _gridDB;
				};
				case "Ambush": {
					// Setup Logic Values 
					_current = ["read", [_x, "AmbushCount"]] call _gridDB;

					// Add the new Ambush to the area
					[_x, _allegiance, _triggerPos] call lmn_fnc_prepAmbush;
					_newCount = _current + 1;

					// Update the database
					["write", [_x, "AmbushCount", _newCount]] call _gridDB;
				};
				case "AA": {
					// Setup Logic Values 
					_current = ["read", [_x, "AAsites"]] call _gridDB;

					// Add the new Ambush to the area
					[_x, _allegiance, _triggerPos] call lmn_fnc_prepAmbush;
					_newCount = _current + 1;

					// Update the database
					["write", [_x, "AAsites", _newCount]] call _gridDB;
				};
				case "Artillery": {
					// Setup Logic Values 
					_current = ["read", [_x, "MortarSites"]] call _gridDB;

					// Add the new Ambush to the area
					[_x, _allegiance, _triggerPos] call lmn_fnc_prepAmbush;
					_newCount = _current + 1;

					// Update the database
					["write", [_x, "MortarSites", _newCount]] call _gridDB;
				};
			};

			// Inform for Debug
			systemChat format ["Grid %1 is receiving a new %2 reinforcement", _x, _reinforceType];
			
			// Update the database 
			["write", [_x, "dayEvent", "Reinforce"]] call _gridDB;
		};
		case "build": {
			systemChat format ["Grid %1: Building infrastructure!", _x];
			// Logic to build or repair infrastructure
			// [_x, _currentInfrastructure] call lmn_fnc_gridBuild;
			["write", [_x, "dayEvent", "Build"]] call _gridDB;
		};
		case "transfer": {
			systemChat format ["Grid %1: Transferring forces to another location!", _x];
			// Logic to transfer forces to another location
			[_target, _x] call lmn_fnc_wdTransfer;
			["write", [_x, "dayEvent", "Transfer"]] call _gridDB;
		};
		case "probe": {
			systemChat format ["Grid %1: Probing enemy defenses!", _x];
			// Logic to send out reconnaissance or probing attacks
			// [_x, _currentForces] call lmn_fnc_gridProbe;
			["write", [_x, "dayEvent", "Probe"]] call _gridDB;
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
