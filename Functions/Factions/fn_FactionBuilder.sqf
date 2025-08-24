// Get the unit details to be built
params [
	"_formationName",
	"_unitSize",
	"_parentUnit",
	"_composition",
	"_missions",
	"_status",
	"_currentStrength",
	"_location",
	"_morale",
	"_experienceLevel",
	"_supplyLevel"
];

// Save to the database 
_db = ["new", format ["%1 - %2 %3", _parentUnit, missionName, worldName]] call oo_inidbi;
["write", [_formationName, "Size", _unitSize]] call _db;
["write", [_formationName, "Composition", _composition]] call _db;
["write", [_formationName, "Missions", _missions]] call _db;
["write", [_formationName, "Status", _status]] call _db;
["write", [_formationName, "CurrentStrength", _currentStrength]] call _db;
["write", [_formationName, "Location", _location]] call _db;
["write", [_formationName, "Morale", _morale]] call _db;
["write", [_formationName, "ExperienceLevel", _experienceLevel]] call _db;
["write", [_formationName, "SupplyLevel", _supplyLevel]] call _db;
