params ["_loc", "_varName", "_data"];
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Save data to the database
["write", [_loc, _varName, _data]] call _locDB;

systemChat format ["Saved %1", _loc];