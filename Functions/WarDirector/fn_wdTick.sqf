// A tick / Script loop that adds the decision making logic to the war director and orders AI to move 
// around the map, attack objectives, defend areas, etc.

// Pull database 
_gridDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_grids = "getSections" call _gridDB;

// Main loop
{
	systemChat format ["Assessing %1", _x];
	// Define Variables to use in logic
	_isFrontline = false;
	_currentSide = ["read", [_x, "Allegiance"]] call _gridDB;
	_currentgarrisonSize = ["read", [_x, "GarrisonSize"]] call _gridDB;
	_triggerPos = ["read", [_x, "Pos"]] call _gridDB;
	_currentStatus = ["read", [_x, "dayEvent"]] call _gridDB;
	_nearLocs = ["read", [_x, "NearLocations"]] call _gridDB;

	// Decision math 
	_attack = 0;
	_defend = 0;
	_reinforce = 0;
	_build = 0;
	_probe = 0;
	_airAttack = 0;
	_artillery = 0;

	// Check current situation in the grid
	_west = ["USA", "ROK", "AUS", "NZ"];
	_east = ["North"];
	_target = [];
	{
		_side = ["read", [_x, "Allegiance"]] call _gridDB;
		if (((_side in _west) AND (_currentSide in _west)) OR ((_side in _east) AND (_currentSide in _east))) then {
			// Not a frontline unit, consider reinforcing or defending / setting up infra
			_isFrontline = false;
			_reinforce = _reinforce + 1;
			_build = _build + 1;
			_airAttack = _airAttack + 1;	
		}
		else {
			_isFrontline = true;
			_reinforce = _reinforce + 1;
			_garrisonSize = ["read", [_x, "GarrisonSize"]] call _gridDB;
			_target pushback _x;
			if (_garrisonSize > _currentgarrisonSize) then {
				// Enemy has more power, consider retreating or calling reinforcements
				_reinforce = _reinforce + 1;
				_build = _build + 1;
				_defend = _defend + 1;
				_artillery = _artillery + 1;
			} else {
				// We have more power, consider attacking or fortifying position
				_attack = _attack + 1;
				_probe = _probe + 1;
				_airAttack = _airAttack + 1;
			};
		};
	} forEach _nearLocs;

	// Decide what to do based on importance, player presence, current forces, etc.
	_orders = selectRandomWeighted [
		"attack", _attack,
		"defend", _defend,
		"reinforce", _reinforce,
		"build", _build,
		"probe", _probe,
		"airAttack", _airAttack,
		"artillery", _artillery,
		"hold", 1
	];

	// Issue orders to forces in the grid
	switch (_orders) do {
		case "attack": {
			systemChat format ["Grid %1: Attacking enemy forces!", _target];
			// Logic to move forces to attack enemy positions
			[_x, _currentgarrisonSize, selectRandom _target] call lmn_fnc_wdAttack;
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
	sleep 10;
} forEach _grids;
