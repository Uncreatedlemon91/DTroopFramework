params ["_loc", "_allegiance", "_remake"];

// Define the databases being used 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Set priority of the location
_lowPriority = [
	"NameLocal",
	"NameVillage",
	"Name",
	"VegetationBroadleaf"
];
_midPriority = [
	"Hill",
	"NameMarine",
	"ViewPoint",
	"Strategic",
	"NameCity"
];
_highPriority = [
	"Airport",
	"NameMarine",
	"StrongpointArea",
	"NameCityCapital"
];

_priority = 1;
_mkr = createMarkerLocal [format ["%1-%2",text _loc, position _loc], position _loc];
if (type _loc in _lowPriority) then {
	_mkr setMarkerSizeLocal [0.8,0.8];
	_priority = 1;
};
if (type _loc in _midPriority) then {
	_mkr setMarkerSizeLocal [1,1];
	_priority = 2;
};
if (type _loc in _highPriority) then {
	_mkr setMarkerSizeLocal [1.2,1.2];
	_priority = 3;
};

// Set the allegiance of the location 
if (isNil "_allegiance") then {
	_allegiance = "North";
};
_mkr setMarkerType "vn_flag_pavn";
_mkr setMarkerAlpha 0.4;
if (isNil "_remake") then {
	if ((position _loc) inArea "SouthAO") then {
	_allegiance = selectRandomWeighted ["USA", 0.3, "ROK", 0.5, "AUS", 0.2, "NZ", 0.1];
	};
	if (((position _loc) inArea "Base") OR ((position _loc) inArea "AirBase")) then {
		_allegiance = "USA";
	};
	if ((position _loc) inArea "Saigon") then {
		_allegiance = "ROK";
	};
};

switch (_allegiance) do {
	case "USA": {_mkr setMarkerType "vn_flag_usa";};
	case "ROK": {_mkr setMarkerType "vn_flag_arvn";};
	case "AUS": {_mkr setMarkerType "vn_flag_aus";};
	case "NZ": {_mkr setMarkerType "vn_flag_nz";};
};

// Set the population 
_houses = nearestTerrainObjects [position _loc, ["HOUSE"], 800];
_houseCount = count _houses;
_population = round (_houseCount / 4);
if (_population > 40) then {
	_population = 40;
};

// Set the resource of the location 
_resource = selectRandom ["Fuel", "Munitions", "Manpower"];
_resourceQty = 1 * _priority;

// Get nearby locations 
_locs = nearestLocations [position _loc, [
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
], 2000];
_nearLocs = [];
{
	_nearLocs pushback (str _loc);
} forEach _locs;
_nearLocs deleteAt 0;

// Set other Variables 
_ambushes = (round(random 8)) * _priority;
_garrisonSize = (round(random 8)) * _priority;
_stability = round(random 100);
_mortarSites = selectRandom [0, 1, 2];
_minefields = round(random 2) * _priority;
_aaSites = (round(random 4)) * _priority;

// Save the location 
["write", [_loc, "Name", text _loc]] call _locDB;
["write", [_loc, "Pos", position _loc]] call _locDB;
["write", [_loc, "CreationTime", systemTime]] call _locDB;
["write", [_loc, "Marker", _mkr]] call _locDB;
["write", [_loc, "Population", _population]] call _locDB;
["write", [_loc, "Resource", _resource]] call _locDB;
["write", [_loc, "ResourceQty", _resourceQty]] call _locDB;
["write", [_loc, "NearLocations", _nearLocs]] call _locDB;
["write", [_loc, "Priority", _priority]] call _locDB;
["write", [_loc, "Allegiance", _allegiance]] call _locDB;
["write", [_loc, "Stability", _stability]] call _locDB;
["write", [_loc, "dayEvent", ""]] call _locDB;
["write", [_loc, "AmbushCount", _ambushes]] call _locDB;
["write", [_loc, "GarrisonSize", _garrisonSize]] call _locDB;
["write", [_loc, "MortarSites", _mortarSites]] call _locDB;
["write", [_loc, "MinefieldSites", _minefields]] call _locDB;
["write", [_loc, "AAsites", _aaSites]] call _locDB;

// All Location specifics 
// Spawn civilians 
for "_i" from 1 to _population do {
	_newSite = [_loc, _stability, position _loc] remoteExec ["lmn_fnc_prepCiv", 2];
};

// Spawn AA site Locations 
for "_i" from 1 to _aaSites do {
	_newSite = [_loc, _allegiance, position _loc] remoteExec ["lmn_fnc_prepAA", 2];
};

// Spawn Garrison site Locations 
for "_i" from 1 to _garrisonSize do {
	_newSite = [_loc, _allegiance, position _loc] remoteExec ["lmn_fnc_prepGarrison", 2];
};

// Spawn Artillery site locations 
for "_i" from 1 to _mortarSites do {
	_newSite = [_loc, _allegiance, position _loc] remoteExec ["lmn_fnc_prepArty", 2];
};

// Spawn Ambush Sites
for "_i" from 1 to _ambushes do {
	_newSite = [_loc, _allegiance, position _loc] remoteExec ["lmn_fnc_prepAmbush", 2];
};

// "NORTH" Location specifics 
if (_allegiance == "North") then {
	// Spawn ambush locations 
	for "_i" from 1 to _minefields do {
		_newSite = [_loc, _allegiance, position _loc] remoteExec ["lmn_fnc_prepTraps", 2];
	};
};