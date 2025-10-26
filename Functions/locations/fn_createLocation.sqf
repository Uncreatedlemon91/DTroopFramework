params ["_loc", "_faction", "_remake"];

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
_flagSize = 1;
_civMax = 1;
_mkr = createMarkerLocal [format ["%1-%2",text _loc, position _loc], position _loc];
if (type _loc in _lowPriority) then {
	_flagSize = 0.7;
	_priority = 1;
	_civMax = 5;
};
if (type _loc in _midPriority) then {
	_priority = 2;
	_civMax = 20
};
if (type _loc in _highPriority) then {
	_flagSize = 1.2;
	_priority = 3;
	_civMax = 5
};
_mkr setMarkerSizeLocal [_flagSize, _flagSize];
_mkr setMarkerAlpha 0.4;
if (isNil "_faction") then {
	// Assign Northern Bases
	_faction = "PAVN";

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

_flag = "vn_flag_pavn";
switch (_faction) do {
	case "USA": {_flag = "vn_flag_usa";};
	case "ARVN": {_flag = "vn_flag_arvn";};
};
_mkr setMarkerType _flag;

// Set other Variables 
_troopCount = round (random [50, 100, 150]);
_maxTroopCount = round (_troopCount * _priority);
_supplyLevel = round (random [100, 200, 300]);
_siteType = type _loc;
_security = round (random 100);
_civCount = round (random _civMax);
_activeTroops = [];

// Get nearby locations and save them in an array 
_locs = nearestLocations [position _loc, lmn_locations, 1500];
_nearLocs = [];
{
	_nearLocs pushback text _x;	
} forEach _locs;

_oppositeSide = "";
if ((_faction == "US") OR (_faction == "ARVN")) then {
	_oppositeSide = "EAST";
};
if (_faction == "PAVN") then {
	_oppositeSide = "WEST";
};

// Build the trigger at the location 
_trig = createTrigger ["EmptyDetector", position _loc, true];
_trig setTriggerArea [1500, 1500, 0, false, 300];
_trig setTriggerActivation [_oppositeSide, "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_tdTick',2];",
	"thisTrigger setVariable ['Activated', false, true]"
];

// Set Trigger Variables 
_trig setVariable ["Location", text _loc, true];
_trig setVariable ["Activated", false, true];

// Save to database 
_data = [
	_nearLocs,
	position _loc,
	_faction,
	_troopCount,
	_maxTroopCount,
	_supplyLevel,
	_siteType,
	_security,
	_flag,
	_flagSize,
	_civCount,
	text _loc,
	_activeTroops
];

// Save the location 
["write", [text _loc, "Data", _data]] call _locDB;