// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	// Grab data from the database 
	_position = ["read", [_x, "Position"]] call _locDB;
	_faction = ["read", [_x, "Faction"]] call _locDB;
	_heatLevel = ["read", [_x, "Heat Level"]] call _locDB;
	_civCount = ["read", [_x, "Civilian Count"]] call _locDB;
	_security = ["read", [_x, "Security"]] call _locDB;

	// Define variables 
	_flagType = "";
	switch (_faction) do {
		case "VN_ARVN": {_flagType = "vn_flag_arvn"};
		case "VN_PAVN": {_flagType = "vn_flag_PAVN"};
		case "VN_MACV": {_flagType = "vn_flag_usa"};
	};

	// Create Marker 
	_locationMarker = createMarker [_x, _position];
	_locationMarker setMarkerType _flagType;
	_locationMarker setMarkerSize [0.5, 0.5];
	_locationMarker = ["write", [_x, "Location Marker", _locationMarker]] call _locDB;

	sleep 0.02;
} forEach _sections;