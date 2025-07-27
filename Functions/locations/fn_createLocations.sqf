// Locations are listed on the map 
// Define the databases being used 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_ambushLoc = ["new", format ["Ambushes %1 %2", missionName, worldName]] call oo_inidbi;

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
		_mkr setMarkerSizeLocal [20,20];
		_priority = 1;
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerSizeLocal [40,40];
		_priority = 2;
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerSizeLocal [80,80];
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

	// Build forces in the location 
	// initial force presence 
	_infantryGroupsCount = (round (random 10)) * _priority;
	
	// Build Ambushes 
	if (_allegiance == "North") then {
		_ambushCount = round (random 10) * _priority;
		for "_i" from 1 to _ambushCount do {
			_ambushType = selectRandom ["Road", "Trail", "Mount"];
			_pos = [];
			switch (_ambushType) do {
				case "Road": {
					_pos = selectRandom (nearestTerrainObjects [position _x, [_ambushType], 600, false, true]);
				};
				case "Trail": {
					_pos = selectRandom (nearestTerrainObjects [position _x, [_ambushType], 600, false, true]);
				};
				case "Mount": {
					_pos = selectRandom (nearestLocations [position _x, [_ambushType], 600]);
				};
			};
			_countOfTroops = (random [4, 8, 12]) * _priority;
			_hasEmplacement = selectRandomWeighted [true, 0.3, false 0.7];
			_hasMine = selectRandomWeighted [true, 0.3, false 0.7];
		};
	};

    // Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", position _x];
	_trg setTriggerArea [800, 800, 0, false, 400];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setVariable ["attachedLocation", _x];
	_trg setVariable ["Active", false];
	_trg setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
		"thisTrigger setVariable ['Active', false]"
	];

	// Save the location 
	["write", [_x, "Pos", position _x]] call _locDB;
	["write", [_x, "Priority", _priority]] call _locDB;
    ["write", [_x, "Allegiance", _allegiance]] call _locDB;
	["write", [_x, "InfantryGroups", _infantryGroupsCount]] call _locDB;
	["write", [_x, "Ambushes", _ambushes]] call _locDB;
} forEach _locations;

systemChat "[DB] Locations Generated";