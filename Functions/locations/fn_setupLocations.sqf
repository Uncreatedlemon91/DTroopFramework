// Locations are listed on the map 

lmn_locations = [
	// "mount",
	"NameLocal",
	"NameVillage",
	"Name",
	"VegetationBroadleaf",
	"Hill",
	"NameMarine",
	"ViewPoint",
	"Strategic",
	"NameCity",
	"Airport",
	"NameMarine",
	"StrongpointArea",
	"NameCityCapital"
];

// Scan and setup the markers for each location as well as their variables.
Missionlocations = nearestLocations [[0,0,0], lmn_locations, worldsize * 4];
{
	[_x] remoteExec ["lmn_fnc_createLocation", 2];
	sleep 0.01;
} forEach Missionlocations;
