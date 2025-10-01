// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	// Current result is saved in variable _x
	_pos = ["read", [_x, "Pos"]] call _locDB;
	_allegiance = ["read", [_x, "Allegiance"]] call _locDB;
	_priority = ["read", [_x, "Priority"]] call _locDB;
	_population = ["read", [_x, "Population"]] call _locDB;
	_ambushes = ["read", [_x, "AmbushCount"]] call _locDB;
	_aaSites = ["read", [_x, "AAsites"]] call _locDB;
	_garrisonSize = ["read", [_x, "GarrisonSize"]] call _locDB;
	_stability = ["read", [_x, "Stability"]] call _locDB;
	_mortarSites = ["read", [_x, "MortarSites"]] call _locDB;

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

	// Spawn civilians 
	for "_i" from 1 to _population do {
		_newSite = [_x, _stability, _pos] remoteExec ["lmn_fnc_prepCiv", 2];
	};

	// Spawn ambush locations 
	for "_i" from 1 to _ambushes do {
		_newSite = [_x, _allegiance, _pos] remoteExec ["lmn_fnc_prepAmbush", 2];
	};

	// Spawn AA site Locations 
	for "_i" from 1 to _aaSites do {
		_newSite = [_x, _allegiance, _pos] remoteExec ["lmn_fnc_prepAA", 2];
	};

	// Spawn Garrison site Locations 
	for "_i" from 1 to _garrisonSize do {
		_newSite = [_x, _allegiance, _pos] remoteExec ["lmn_fnc_prepGarrison", 2];
	};

	// Spawn Artillery site locations 
	for "_i" from 1 to _mortarSites do {
		_newSite = [_x, _allegiance, _pos] remoteExec ["lmn_fnc_prepArty", 2];
	};
} forEach _sections;



// systemChat "[DB] Locations Loaded";