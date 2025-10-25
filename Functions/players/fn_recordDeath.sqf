// Records the death to the database 
params ["_unitName", "_date" ,"_time"];

// Create database 
_db = ["new", format ["Casualties %1 %2", missionName, worldName]] call oo_inidbi;

// Write to the database 
["write", [_date, _time, _unitName]] call _db;