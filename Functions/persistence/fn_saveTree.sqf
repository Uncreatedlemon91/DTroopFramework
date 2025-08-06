// Saves a tree removal 
params ["_tree"];

hideObjectGlobal _tree;

// Save entry so we can reload it later
_db = ["new", format ["Removed Trees %1 %2", missionName, worldName]] call oo_inidbi;
["write", [format ["%1", _tree], "Position", (position _tree)]] call _db;