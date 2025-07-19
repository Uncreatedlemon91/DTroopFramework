// Deletes an item in real space and database 
params ["_item"];

_section = netId _item;
_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;

["deleteSection", _section] call _db;
deleteVehicle _item;