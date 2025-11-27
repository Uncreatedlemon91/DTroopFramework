// Creates locations and saves them to the Database and Hashmap. 

// Calculate the center of the map and the radius needed to cover it
_worldCenter = [worldSize / 2, worldSize / 2, 0];
_maxRadius = sqrt (2 * (worldSize / 2) ^ 2); // Pythagoras to get corner-to-corner coverage

// Define the types of locations you want
_types = ["NameCity", "NameCityCapital", "NameVillage", "Airport", "Hill", "NameMarine", "StrongpointArea", "RockArea", "Name", "VegetationBroadleaf"];
_allLocations = nearestLocations [_worldCenter, _types, _maxRadius];

// Add a marker to the location 
{
	// Location variables 
	_faction = "PAVN";
	_mkrType = "vn_flag_pavn";
	_mkrSize = [0.5, 0.5];
	_security = round(random 100);
	_heat = 0;

	// Define based on location 
	if ((position _x) inArea ("blufor")) then {
		_faction = "USA";
		_mkrType = "vn_flag_usa";
	};
	if ((position _x) inArea ("indfor")) then {
		_faction = "ARVN";
		_mkrType = "vn_flag_arvn";
	};
	if ((position _x) inArea ("opfor")) then {
		_faction = "PAVN";
		_mkrType = "vn_flag_pavn";
	};

	// Create the marker
	_mkr = createMarkerLocal [text _x, position _x];
	_mkr setMarkerTypeLocal _mkrType;
	_mkr setMarkerSize _mkrSize;
	LemonLocations set [_mkr, [_faction, _mkrType, position _x, _mkrSize, _security, _heat, type _x]];
	sleep 0.01;
} forEach _allLocations;

// Add to the database 
_db = ["new", "Locations"] call oo_inidbi;
_keys = keys LemonLocations;
{
	// Current result is saved in variable _x
	_data = LemonLocations get _x;
	["write", [_x, "Data", _data]] call _db;
	sleep 0.01;
} forEach _keys;

// Notice that module completed 
systemChat "[Locations] - Created";

// Run the script to autosave 
[] remoteExec ["lmn_fnc_locationsSave", 2];
[] remoteExec ["lmn_fnc_directorAssess", 2];