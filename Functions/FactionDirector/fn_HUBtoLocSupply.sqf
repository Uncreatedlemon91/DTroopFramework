// Creates a virtualized convoy from Logistics HUB to a low supply location
params ["_dest", "_faction", "_hub"];

// Get the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// create Variables 
_supplyVeh = "";
_side = "";
_supplyQty = 0;
_dropOff = ["read", [_dest, "Position"]] call _locDB;
_startPos = ["read", [_hub, "Position"]] call _locDB;

// Update variables 
switch (_faction) do {
	case "USA": {
		_supplyVeh = "" // Model of truck
		_side = west; // Set side of spawned object
		_supplyQty = 20; // Amount to increase supply by
	};
};