// Updates the grid with changes either through player interaction or war director input. 
params ["_trg", "_newItem", "_newItemType"];

// Define what to update 
switch (_newItemType) do {
	case "force": {
		// Add the new force to the grid's forces array
		_trg setVariable ["gridForces", (_trg getVariable "gridForces") + [_newItem], true];
	};
	case "infrastructure": {
		// Add the new infrastructure to the grid's infrastructure array
		_trg setVariable ["gridInfrastructure", (_trg getVariable "gridInfrastructure") + [_newItem], true];
	};
	case "side": {
		// Change the controlling side of the grid
		_trg setVariable ["gridSide", _newItem, true];
	};
	case "forcePower": {
		// Update the force power of the grid
		_trg setVariable ["gridForcePower", _newItem, true];
	};
	case "status": {
		// Update the status of the grid (e.g., contested, secure, lost)
		_trg setVariable ["gridStatus", _newItem, true];
	};
	default {
		hint "Unknown item type for grid update.";
	};
};

// Update the database 
_gridDB = ["new", format ["Grids %1 %2", missionName, worldName]] call oo_inidbi;
_data = [_trg getVariable "gridCoords", _trg getVariable "gridSide", _trg getVariable "gridForcePower", _trg getVariable "gridForces", _trg getVariable "gridInfrastructure", _triggerPos];
["write", [format ["Grid-%1-%2", _x, _y], "gridData", _data]] call _gridDB;