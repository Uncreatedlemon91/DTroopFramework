// Locations are listed on the map 
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

_allLocations pushBack _lowPriority;
_allLocations pushback _midPriority;
_allLocations pushback _highPriority;

_locations = nearestLocations [[0,0,0], _allLocations, worldsize * 4];
{
	_mkr = createMarkerLocal [text _x, position _x];
	_mkr setMarkerType "hd_flag";
	if (type _x in _lowPriority) then {
		_mkr setMarkerColor "ColorBlue";
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerColor "ColorYellow";
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerColor "ColorRed";
	};
	_mkr setMarkerText (type _x);
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