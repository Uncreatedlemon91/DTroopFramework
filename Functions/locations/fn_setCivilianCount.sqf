// Sets the civilian count for the location 
params ["_loc"];

// Check if the location is a military point
if ((type _loc == "StrongpointArea") OR (type _loc == "Airport")) exitWith {
	0;
};

// Get the number of houses 
_houses = nearestTerrainObjects [position _loc, ["HOUSE"], 500];
_housesCount = count _houses;

// Math the number of civilians 
_civCount = round (_housesCount / 3);

// Return the civilian count
_civCount;