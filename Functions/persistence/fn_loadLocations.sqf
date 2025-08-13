// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	// Current result is saved in variable _x
	_pos = ["read", [_x, "Pos"]] call _locDB;
	_allegiance = ["read", [_x, "Allegiance"]] call _locDB;
	_priority = ["read", [_x, "Priority"]] call _locDB;

	// Create a trigger nearestLocation
	_location = nearestLocation [_pos, ""];
	[_location] remoteExec ["lmn_fnc_createLocTrigger", 2];

	// Create a marker
	_mkr = createMarkerLocal [format ["%1-%2",text _x, _pos], _pos];
	_mkr setMarkerAlpha 0.4;
	if (_priority == 1) then {
		_mkr setMarkerSizeLocal [0.8,0.8];
	};
	if (_priority == 2) then {
		_mkr setMarkerSizeLocal [1,1];
	};
	if (_priority == 3) then {
		_mkr setMarkerSizeLocal [1.2,1.2];
	};

	switch (_allegiance) do {
		case "USA": {_mkr setMarkerType "vn_flag_usa";};
		case "ROK": {_mkr setMarkerType "vn_flag_arvn";};
		case "AUS": {_mkr setMarkerType "vn_flag_aus";};
		case "NZ": {_mkr setMarkerType "vn_flag_nz";};
		case "North": {_mkr setMarkerType "vn_flag_pavn";};
	};
} forEach _sections;

// systemChat "[DB] Locations Loaded";