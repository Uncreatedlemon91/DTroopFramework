// Records the death to the database 
params ["_unitName", "_killerName", "_killerType", "_date" ,"_time"];

// Create database 
_db = ["new", format ["Player Deaths %1 %2", missionName, worldName]] call oo_inidbi;

// Write to the database 
["write", [_date, _time, format ["%1 killed by %2 (%3)", _unitName, _killerName, _killerType]]] call _db;