// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	// Current result is saved in variable _x
	_pos = ["read", [_x, "Pos"]] call _locDB;
	_allegiance = ["read", [_x, "Allegiance"]] call _locDB;
    _munitions = ["read", [_x, "Munitions"]] call _locDB;
    _fuel = ["read", [_x, "Fuel"]] call _locDB;
    _construction = ["read", [_x, "Construction"]] call _locDB;
    _manpower = ["read", [_x, "Manpower"]] call _locDB;
    _forces = ["read", [_x, "Forces"]] call _locDB;
    _priority = ["read", [_x, "Priority"]] call _locDB;

	// Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", _pos];
	_trg setTriggerArea [800, 800, 0, false, 400];
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

	// Create a marker
	_mkr = createMarkerLocal [format ["%1-%2",text _x, position _x], position _x];
	_mkr setMarkerType "hd_flag";
	if (_priority == 0) then {
		_mkr setMarkerColor "ColorBlue";
	};
	if (_priority == 1) then {
		_mkr setMarkerColor "ColorYellow";
	};
	if (_priority == 2) then {
		_mkr setMarkerColor "ColorRed";
	};
} forEach _sections;