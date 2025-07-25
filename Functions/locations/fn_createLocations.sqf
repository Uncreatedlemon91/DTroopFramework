// Locations are listed on the map 
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
	_priority = 0;
	_mkr = createMarkerLocal [format ["%1-%2",text _x, position _x], position _x];
	if (type _x in _lowPriority) then {
		_priority = 0;
	};
	if (type _x in _midPriority) then {
		_priority = 1;
	};
	if (type _x in _highPriority) then {
		_priority = 2;
	};

	// Set the allegiance of the location 
    _allegiance = "North";
	_mkr setMarkerType "vn_flag_pavn";
    if ((position _x) inArea "SouthAO") then {
        _allegiance = selectRandom ["USA", "ROK", "AUS", "NZ"];
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

	// Save the location 
    _locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	["write", [_x, "Pos", position _x]] call _locDB;
	["write", [_x, "Priority", _priority]] call _locDB;
    ["write", [_x, "Allegiance", _allegiance]] call _locDB;

    // Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", position _x];
	_trg setTriggerArea [800, 800, 0, false, 400];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setVariable ["attachedLocation", _x];
	_trg setVariable ["Active", false];
    _trg setVariable ["Allegiance", _allegiance];
    _trg setVariable ["Priority", _priority];
	_trg setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
		"thisTrigger setVariable ['Active', false]"
	];
} forEach _locations;

systemChat "[DB] Locations Generated";