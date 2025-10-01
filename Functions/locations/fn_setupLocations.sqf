// Locations are listed on the map 

lmn_locations = [
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
	sleep 0.1;
} forEach Missionlocations;

// Run the War Director
[] remoteExec ["lmn_fnc_wdTick", 2];
[] remoteExec ["lmn_fnc_loadItems", 2];

// Run the War Director
[] remoteExec ["lmn_fnc_wdTick", 2];

systemChat "[DB] Locations Generated";