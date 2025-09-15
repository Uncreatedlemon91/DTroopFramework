// A tick / Script loop that adds the decision making logic to the war director and orders AI to move 
// around the map, attack objectives, defend areas, etc.

// Pull database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_grids = "getSections" call _gridDB;

// Main loop
{
	// Define Variables to use in logic
	_isFrontline = false;

	_currentSide = ["read", [_x, "Side"]] call _gridDB;
	_currentForcePower = ["read", [_x, "ForcePower"]] call _gridDB;
	_currentForces = ["read", [_x, "Forces"]] call _gridDB;
	_currentInfrastructure = ["read", [_x, "Infrastructure"]] call _gridDB;
	_triggerPos = ["read", [_x, "Position"]] call _gridDB;
	_currentStatus = ["read", [_x, "Status"]] call _gridDB;

	// Decision math 
	_attack = 0;
	_defend = 0;
	_reinforce = 10;
	_build = 0;
	_probe = 0;
	_airAttack = 0;
	_artillery = 0;

	// Check current situation in the grid
	_triggers = nearestObjects [_triggerPos, ["EmptyDetector"], 1000];
	{
		_side = _x getVariable "gridSide";
		if (_side == _currentSide) then {} 
		else {
			_isFrontline = true;
			_reinforce = _reinforce + 1;
			_forcePower = _x getVariable "gridForcePower";
			if (_forcePower > _currentForcePower) then {
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
	} forEach _triggers;

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
			systemChat format ["Grid %1: Attacking enemy forces!", _x];
			// Logic to move forces to attack enemy positions
			// [_x, _currentForces] call lmn_fnc_gridAttack;
		};
		case "defend": {
			systemChat format ["Grid %1: Fortifying defenses!", _x];
			// Logic to fortify current position
			// [_x, _currentForces] call lmn_fnc_gridDefend;
		};
		case "reinforce": {
			systemChat format ["Grid %1: Calling reinforcements!", _x];
			// Logic to call in reinforcements
			[_x, _currentSide] call lmn_fnc_gridReinforce;
		};
		case "build": {
			systemChat format ["Grid %1: Building infrastructure!", _x];
			// Logic to build or repair infrastructure
			// [_x, _currentInfrastructure] call lmn_fnc_gridBuild;
		};
		case "probe": {
			systemChat format ["Grid %1: Probing enemy defenses!", _x];
			// Logic to send out reconnaissance or probing attacks
			// [_x, _currentForces] call lmn_fnc_gridProbe;
		};
		case "airAttack": {
			systemChat format ["Grid %1: Launching air attack!", _x];
			// Logic to call in air support
			// [_x, _currentSide] call lmn_fnc_gridAirAttack;
		};
		case "artillery": {
			systemChat format ["Grid %1: Bombarding enemy positions!", _x];
			// Logic to call in artillery support
			// [_x, _currentSide] call lmn_fnc_gridArtillery;
		};
		case "hold": {
			systemChat format ["Grid %1: Holding position.", _x];
			// Logic to hold current position and maintain readiness
			// [_x, _currentForces] call lmn_fnc_gridHold;
		};
		default {
			systemChat format ["Grid %1: No action taken.", _x];
		};
	};
	sleep 2;
} forEach _grids;

sleep 100; 
[] remoteExec ["lmn_fnc_wdTick", 2]; // Repeat every 100 seconds