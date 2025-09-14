// Reinforce the map grid with forces based on current situation
params ["_dbEntry", "_side"];

_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_data = ["read", [_dbEntry, "gridData"]] call _gridDB;

_triggerPos = _data select 5; 
_trg = nearestObject [_triggerPos, "EmptyDetector"];
_forcePower = _trg getVariable "gridForcePower";
_forces = _trg getVariable "gridForces";

switch (_side) do {
	case "North": {
		_reincforments = selectRandom [
			lmn_pavn_inf_platoon,
			lmn_pavn_turret_PK,
			lmn_pavn_turret_M1910,
			lmn_pavn_turret_SpiderHole
		]
	};
	default { };
};

// Add the new force to the grid's forces array
_trg setVariable ["gridForces", _forces + [_reincforments], true];

// Update the force power of the grid
_trg setVariable ["gridForcePower", _forcePower + (_reincforments select 1), true];

// Update the database
_data = [_trg getVariable "gridCoords", _trg getVariable "gridSide", _trg getVariable "gridForcePower", _trg getVariable "gridForces", _trg getVariable "gridInfrastructure", _triggerPos];
["write", [format ["Grid-%1", (_trg getVariable "gridCoords") select 0, "gridData", _data]]] call _gridDB;