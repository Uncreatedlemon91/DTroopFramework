// Locations are listed on the map 
_allLocations = [];
_lowPriority = [
	// "Mount",
	"NameLocal",
	"NameVillage",
	"Name",
	"VegetationBroadleaf"
];
_midPriority = [
	"Hill",
	"ViewPoint",
	"Strategic"
];
_highPriority = [
	"Airport",
	"NameMarine",
	"StrongpointArea"
];

_allLocations append _lowPriority; 
_allLocations append _midPriority;
_allLocations append _highPriority;

// Scan and setup the markers for each location as well as their variables.
_locations = nearestLocations [[0,0,0], _allLocations, worldsize * 4];
{
	_priority = 0;
	_mkr = createMarkerLocal [format ["%1-%2",text _x, position _x], position _x];
	_mkr setMarkerType "hd_flag";
	if (type _x in _lowPriority) then {
		_mkr setMarkerColor "ColorBlue";
		_priority = 0;
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerColor "ColorYellow";
		_priority = 1;
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerColor "ColorRed";
		_priority = 2;
	};

    // Save the location 
    _locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

    _munitions = round (random 100);
    _fuel = round (random 100);
    _construction = round (random 100);
    _manpower = round (random 100);

    _infantry = round (random 10);
    _aa = round (random 10);
    _turrets = round (random 10);
    _armor = round (random 4);
    _forces = [_infantry, _aa, _turrets, _armor];
        
    _allegiance = "North";
    if ((position _x) inArea "SouthAO") then {
        _allegiance = "South";
    };

	["write", [_x, "Location", _x]] call _locDB;
    ["write", [_x, "Allegiance", _allegiance]] call _locDB;
    ["write", [_x, "Munitions", _munitions]] call _locDB;
    ["write", [_x, "Fuel", _fuel]] call _locDB;
    ["write", [_x, "Construction", _construction]] call _locDB;
    ["write", [_x, "Manpower", _manpower]] call _locDB;
    ["write", [_x, "Forces", _forces]] call _locDB;
    ["write", [_x, "Priority", _priority]] call _locDB;

    // Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", position _x];
	_trg setTriggerArea [600, 600, 0, false, 200];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setVariable ["attachedLocation", _x];
	_trg setVariable ["Active", false];
    _trg setVariable ["Allegiance", _allegiance];
    _trg setVariable ["Munitions", _munitions];
    _trg setVariable ["Fuel", _fuel];
    _trg setVariable ["Construction", _construction];
    _trg setVariable ["Manpower", _manpower];
    _trg setVariable ["Forces", _forces];
    _trg setVariable ["Priority", _priority];
	_trg setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
		"thisTrigger setVariable ['Active', false]"
	];
} forEach _locations;