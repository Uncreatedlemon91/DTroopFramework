params ["_loc", "_faction", "_remake"];

// Define the databases being used 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Set priority of the location
_lowPriority = [
	"mount",
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
if (isNil "_faction") then {
	_faction = "PAVN";
};
_mkr setMarkerType "vn_flag_pavn";
_mkr setMarkerAlpha 0.4;
if (isNil "_remake") then {
	// Assign Southern / Allied Bases
	if ((position _loc) inArea "SouthAO") then {
		_faction = selectRandomWeighted ["USA", 0.3, "ARVN", 0.5];
	};
	// Assign US Bases
	if (((position _loc) inArea "Base") OR ((position _loc) inArea "AirBase")) then {
		_faction = "USA";
	};
	// Assign ARVN Bases
	if ((position _loc) inArea "Saigon") then {
		_faction = "ARVN";
	};
};

switch (_faction) do {
	case "USA": {_mkr setMarkerType "vn_flag_usa";};
	case "ARVN": {_mkr setMarkerType "vn_flag_arvn";};
};

// Set other Variables 
_troopCount = 10;
_maxTroopCount = 50 * _priority;
_supplyLevel = 10;
_siteType = type _loc;
_security = round (random 100);

_data = [
	text _loc,
	position _loc,
	_faction,
	_troopCount,
	_maxTroopCount,
	_supplyLevel,
	_siteType,
	_security 
];

// Save the location 
["write", [_loc, "Data", _data]] call _locDB;
