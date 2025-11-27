// Loads battalions from the DB to the Hashmap 
_db = ["new", "Battalions"] call oo_inidbi;
_sections = "getSections" call _db;

// Get data 
{
	_data = ["read", [_x, "Data"]] call _db;
	LemonBattalions set [_x, _data];

	// Create the marker 
	_mkr = createMarkerLocal [(_data select 1), (_data select 3)];
	_mkr setMarkerTypeLocal (_data select 2);
	_mkr setMarkerSizeLocal [0.5, 0.5];
	_mkr setMarkerText (_data select 1);

	[_mkr] remoteExec ["lmn_fnc_battalionLogic", 2];
} forEach _sections;


// Notify that the battalions have been loaded 
["[Battalions] - Loaded"] remoteExec ["systemChat", 0];