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
_distance = _startPos distance _dropOff;

// Update variables 
switch (_faction) do {
	case "USA": {
		_side = west; // Set side of spawned object
		_supplyVeh = "" // Model of truck
		_supplyQty = 20; // Amount to increase supply by
		
		// If the distance is greater than 1km, use a helicopter and more supplies
		if (_distance > 1000) then {
			_supplyQty = 50;
			_supplyVeh = "" // Chinook
		};
	};
};