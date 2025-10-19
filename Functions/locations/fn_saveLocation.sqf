params ["_loc", "_trig"];

// Package the data
_data = [
	(_trig getVariable "Location"),
	(_trig getVariable "Faction"),
	(_trig getVariable "TroopCount"),
	(_trig getVariable "SiteType"),
	(_trig getVariable "MaxTroopCount"),
	(_trig getVariable "SupplyLevel"),
	(_trig getVariable "Security"),
	(_trig getVariable "Marker")
];

// Save data to the database
["write", [_loc, "Data", _data]] call _locDB;