// Loads battalions from the DB to the Hashmap 
_db = ["new", "Battalions"] call oo_inidbi;
_sections = "getSections" call _db;

{
	// Current result is saved in variable _x
	_data = ["read", [_x, "Data"]] call _db;
	LemonBattalions set [_x, _data];
} forEach _sections;

// Notify that the battalions have been loaded 
["[Battalions] - Loaded"] remoteExec ["systemChat", 0];