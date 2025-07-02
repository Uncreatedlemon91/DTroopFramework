// Locations are listed on the map 
_locations = nearestLocations [[0,0,0], ["", "", ""], worldsize * 4];
{
	_mkr = createMarkerLocal [text _x, position _x];
	_mkr setMarkerType "hd_flag";
	_mkr setMarkerColor "COLORRED";
	_mkr setMarkerText (type _x);
} forEach _locations;

_locations2 = nearestLocations [[0,0,0], ["", "", "", ""], worldsize * 4];
{
	_mkr = createMarkerLocal [format ["%1-%2", text _x, position _x], position _x];
	_mkr setMarkerType "hd_flag";
	_mkr setMarkerColor "COLORBLUE";
	_mkr setMarkerText (type _x);
} forEach _locations2;

/*
// Low Priority Objectives 
"Mount"
"NameLocal"
NameVillage
Name
VegetationBroadleaf

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