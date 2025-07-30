// Locations are listed on the map 
// Define the databases being used 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

_allLocations = [];
_lowPriority = [
	// "Mount",
	"NameLocal",
	"NameVillage",
	"Name",
	"VegetationBroadleaf"
];
_midPriority = [
	"Hill",
	"NameMarine",
	"ViewPoint",
	"Strategic"
];
_highPriority = [
	"Airport",
	"NameMarine",
	"StrongpointArea"
];

_allLocations append _lowPriority; 
_allLocations append _midPriority;
_allLocations append _highPriority;

// Scan and setup the markers for each location as well as their variables.
_locations = nearestLocations [[0,0,0], _allLocations, worldsize * 4];
{
	// Set priority of the location
	_priority = 1;
	_mkr = createMarkerLocal [format ["%1-%2",text _x, position _x], position _x];
	if (type _x in _lowPriority) then {
		_mkr setMarkerSizeLocal [0.8,0.8];
		_priority = 1;
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerSizeLocal [1,1];
		_priority = 2;
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerSizeLocal [1.2,1.2];
		_priority = 3;
	};

	// Set the allegiance of the location 
    _allegiance = "North";
	_mkr setMarkerType "vn_flag_pavn";
    if ((position _x) inArea "SouthAO") then {
        _allegiance = selectRandomWeighted ["USA", 0.5, "ROK", 0.3, "AUS", 0.2, "NZ", 0.1];
    };
	if ((position _x) inArea "Base") then {
		_allegiance = "USA";
	};

	switch (_allegiance) do {
		case "USA": {_mkr setMarkerType "vn_flag_usa";};
		case "ROK": {_mkr setMarkerType "vn_flag_arvn";};
		case "AUS": {_mkr setMarkerType "vn_flag_aus";};
		case "NZ": {_mkr setMarkerType "vn_flag_nz";};
	};

    // Create a Trigger on the location 
	[_x] remoteExec ["lmn_fnc_createLocTrigger", 2];

	// Save the location 
	["write", [_x, "Name", text _x]] call _locDB;
	["write", [_x, "Pos", position _x]] call _locDB;
	["write", [_x, "Priority", _priority]] call _locDB;
    ["write", [_x, "Allegiance", _allegiance]] call _locDB;
	["write", [_x, "Loyalty", round(random 100)]] call _locDB;
} forEach _locations;

systemChat "[DB] Locations Generated";