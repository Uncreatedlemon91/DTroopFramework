params ["_location", "_trig"];

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
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
["write", [_data select 0, "Data", _data]] call _locDB;