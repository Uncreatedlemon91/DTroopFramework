// Gets nearby locations and returns them 
params ["_position", "_radius"];

// Rewrite to pull from database instead 
// Use Faction Key / HEAT key / Position Key
// Return the [Enemy, enemyHighHeat, Friendly, friendlyHighHeat, friendlyLowSecurity]
// Prioritize HEAT / Friendly Low Security / Location

_nearLocs = nearestLocations [_position, [
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
], _radius];
_loc = selectRandom _nearLocs;
_dest = position _loc;

_data = [_loc, _dest];
_data;