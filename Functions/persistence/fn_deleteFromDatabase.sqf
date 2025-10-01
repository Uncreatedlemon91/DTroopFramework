// Deletes an item in real space and database 
params ["_item", "_type"];

_section = _item getVariable "IndexVar";
_db = "";
switch (_type) do {
	case "itemdb": {_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi};
	case "vehdb": {_db = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi};
	default { };
};

// Delete from the database 
["deleteSection", _section] call _db;

// Delete from world
deleteVehicle _item;