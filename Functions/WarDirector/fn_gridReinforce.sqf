// Reinforce the map grid with forces based on current situation
params ["_dbEntry", "_side"];

// Get database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;

// Get information from Grid
_trgID = ["read", [_dbEntry, "Trigger"]] call _gridDB;
_trg = objectFromNetId _trgID;
_reinforcements = [];

switch (_side) do {
	case "North": {
		_reinforcements = selectRandomWeighted [
			lmn_pavn_inf_platoon, 0.5,
			lmn_pavn_turret_PK, 0.2,
			lmn_pavn_turret_M1910, 0.2,
			lmn_pavn_turret_SpiderHole, 0.2
		]
	};

	case "USA": {
		_reinforcements = selectRandomWeighted [
			lmn_usa_inf_platoon, 0.5,
			lmn_usa_turret_M2, 0.2,
			lmn_usa_turret_M60, 0.2,
			lmn_usa_armored_m113, 0.2
		]
	};

	case "ARVN": {
		_reinforcements = selectRandomWeighted [
			lmn_arvn_inf_platoon, 0.5
		]
	};
	default { };
};

// Add the new force to the grid's forces array
_forces = _trg getVariable "gridForces";
_forces pushBack _reinforcements;
_trg setVariable ["gridForces", _forces, true];

// Update the force power of the grid
_trg setVariable ["gridForcePower", (_trg getVariable "gridForcePower") + (_reinforcements select 1), true];

// Debug message
systemChat format ["Reinforced Grid-%1 to %2 (Power +%3)", _dbEntry, _forces, (_reinforcements select 1)];

// Update the database
["write", [_dbEntry, "Forces", (_trg getVariable "gridForces")]] call _gridDB;
["write", [_dbEntry, "ForcePower", (_trg getVariable "gridForcePower")]] call _gridDB;
