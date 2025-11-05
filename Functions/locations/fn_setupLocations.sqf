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
	// Check if the location is Mount, if it is, then only spawn some of them
	//if (position _x inArea "BASE") then{
		if (type _x == "mount") then {
			_random = random 100;
			if (_random < 2) then {
				[_x] remoteExec ["lmn_fnc_createLocation2", 2];
			};
		} else {
			[_x] remoteExec ["lmn_fnc_createLocation2", 2];
		};
	//};
	sleep 0.02;
} forEach Missionlocations;
