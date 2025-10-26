params ["_data"];
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Save data to the database
_location = _data select 11;
["write", [_location, "Data", _data]] call _locDB;

systemChat format ["Saved %1", _location];