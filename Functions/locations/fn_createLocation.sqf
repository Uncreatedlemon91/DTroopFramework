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
_mkr = createMarkerLocal [format ["%1-%2",text _loc, position _loc], position _loc];
if (type _loc in _lowPriority) then {
	_flagSize = 0.7;
	_priority = 1;
};
if (type _loc in _midPriority) then {
	_priority = 2;
};
if (type _loc in _highPriority) then {
	_flagSize = 1.2;
	_priority = 3;
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
_troopCount = random [50, 100, 150];
_maxTroopCount = _troopCount * _priority;
_supplyLevel = random [100, 200, 300];
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
	_security,
	_flag,
	_flagSize
];

// Save the location 
["write", [text _loc, "Data", _data]] call _locDB;

// Build the trigger at the location 
_trig = createTrigger ["EmptyDetector", position _loc, true];
_trig setTriggerArea [1250, 1250, 0, false, 100];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_tdTick',2];",
	"thisTrigger setVariable ['Activated', false]"
];

// Set Trigger Variables 
_trig setVariable ["Location", _loc, true];
_trig setVariable ["Faction", _faction, true];
_trig setVariable ["TroopCount", _troopCount, true];
_trig setVariable ["SiteType", _siteType, true];
_trig setVariable ["Priority", _priority, true];
_trig setVariable ["MaxTroopCount", _maxTroopCount, true];
_trig setVariable ["SupplyLevel", _supplyLevel, true];
_trig setVariable ["Security", _security, true];
_trig setVariable ["Marker", _mkr, true];
_trig setVariable ["Activated", false, true];