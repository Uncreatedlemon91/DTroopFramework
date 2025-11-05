// Sets a location's ID in the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locDB;

// Location ID 
_locCount = count _locs;
_newID = _locCount + 1;

// Send the ID back to the caller
_newID;
