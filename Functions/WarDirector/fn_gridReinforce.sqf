// Reinforce the map grid with forces based on current situation
params ["_dbEntry", "_side"];

// Get database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;

// Get information from Grid
_side = ["read", [_dbEntry, "Side"]] call _gridDB;
_trgID = ["read", [_dbEntry, "Trigger"]] call _gridDB;
_trg = objectFromNetId _trgID;

switch (_side) do {
	case "North": {
		_reinforcements = selectRandom [
			lmn_pavn_inf_platoon,
			lmn_pavn_turret_PK,
			lmn_pavn_turret_M1910,
			lmn_pavn_turret_SpiderHole
		]
	};
	default { };
};

// Add the new force to the grid's forces array
_trg setVariable ["gridForces", (_trg getVariable "gridForces") + [_reinforcements select 0], true];

// Update the force power of the grid
_trg setVariable ["gridForcePower", (_trg getVariable "gridForcePower") + (_reinforcements select 1), true];

// Update the database
["write", [format ["Grid-%1", _dbEntry, "Forces", (_trg getVariable "gridForces")]]] call _gridDB;
["write", [format ["Grid-%1", _dbEntry, "ForcePower"], (_trg getVariable "gridForcePower")]] call _gridDB;