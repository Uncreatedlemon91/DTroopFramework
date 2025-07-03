// Locations are listed on the map 
systemChat "Running Locations";
_allLocations = [];
_lowPriority = [
	"Mount",
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

systemchat format ["%1", _allLocations];
// Scan and setup the markers for each location as well as their variables.
_locations = nearestLocations [[0,0,0], _allLocations, worldsize * 4];
{
	_priority = 0;
	_mkr = createMarkerLocal [text _x, position _x];
	_mkr setMarkerType "hd_flag";
	if (type _x in _lowPriority) then {
		_mkr setMarkerColor "ColorBlue";
		_priority = 0;
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerColor "ColorYellow";
		_priority = 1;
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerColor "ColorRed";
		_priority = 2;
	};

	// Get previous location variables - or save new variables if old ones don't exist.
	_locData = missionProfileNameSpace getVariable [format ["%1-%2-Data", type _x, position _x], [random 100, _priority, random 3, round (Random 3)]];
	SaveMissionProfileNameSpace;

	// Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", position _x];
	_trg setTriggerArea [600, 600, 0, false, 200];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setVariable ["attachedLocation", _x];
	_trg setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
		""
	];
} forEach _locations;

/*
// Low Priority Objectives 
"Mount"
"NameLocal"
"NameVillage"
"Name"
"VegetationBroadleaf"

// Medium Priority 
"Hill"
"ViewPoint"
"Strategic"

// High Priority 
Airport
NameMarine
StrongpointArea

// Not Used 
"HistoricalSite"
"CivilDefense"
"RockArea"
"SafetyZone"
CityCenter
CulturalProperty
Area
BorderCrossing
DangerousForces
BorderCrossing
Flag
FlatArea
FlatAreaCity
FlatAreaCitySmall
Invisible
NameCity
NameCityCapital
SafetyZone
VegetationFir
RockArea
VegetationPalm
VegetationVineyard