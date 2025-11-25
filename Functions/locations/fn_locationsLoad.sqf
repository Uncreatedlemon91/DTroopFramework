// Loads the locations from the database and stores them in the hashmap 

// Pull data from the database 
_db = ["new", "Locations"] call oo_inidbi;
_sections = "getSections" call _db;
_exists = "exists" call _db;
if !(_exists) exitWith {[] remoteExec ["lmn_fnc_locationsCreate", 2]};
{
	// Extract Data 
	_data = ["read", [_x, "Data"]] call _db;
	
	// Create new marker 
	_mkr = createMarkerLocal [_x, (_data select 3)];
	_mkr setMarkerTypelocal (_data select 1);
	_mkr setMarkerSize (_data select 4);

	// Setup the hashmap 
	LemonLocations set [_x, _data];
} forEach _sections;

// Notice that module completed 
systemChat "[Locations] - Loaded";

sleep 1;

// Run the script to autosave 
[] remoteExec ["lmn_fnc_locationsSave", 2];
[] remoteExec ["lmn_fnc_directorAssess", 2];