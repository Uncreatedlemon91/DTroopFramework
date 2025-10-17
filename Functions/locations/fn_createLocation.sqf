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
	_mkr setMarkerSizeLocal [0.5,0.5];
	_priority = 1;
};
if (type _loc in _midPriority) then {
	_mkr setMarkerSizeLocal [1,1];
	_priority = 2;
};
if (type _loc in _highPriority) then {
	_mkr setMarkerSizeLocal [1.5,1.5];
	_priority = 3;
};

_mkr setMarkerAlpha 0.4;
if (isNil "_faction") then {
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
	// Assign Northern Bases
	_faction = "PAVN";
};

switch (_faction) do {
	case "USA": {_mkr setMarkerType "vn_flag_usa";};
	case "ARVN": {_mkr setMarkerType "vn_flag_arvn";};
	case "PAVN": {_mkr setMarkerType "vn_flag_pavn";};
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

// Build the trigger at the location 
_trig = createTrigger ["EmptyDetector", position _loc, true];
_trig setTriggerArea [500, 500, 0, false, 300];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_tdTick',2];",
	"thisTrigger setVariable ['Activated', false]"
];

// Set Trigger Variables 
_trig setVariable ["Location", _loc];
_trig setVariable ["Faction", _faction];
_trig setVariable ["TroopCount", _troopCount];
_trig setVariable ["SiteType", _siteType];
_trig setVariable ["Priority", _priority];
_trig setVariable ["MaxTroopCount", _maxTroopCount];
_trig setVariable ["SupplyLevel", _supplyLevel];
_trig setVariable ["Security", _security];
_trig setVariable ["Marker", _mkr];
_trig setVariable ["Activated", false];