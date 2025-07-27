// Locations are listed on the map 
// Define the databases being used 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

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
	"NameMarine",
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
	// Set priority of the location
	_priority = selectRandom [1,2,3,4,5,6,7,8];
	_mkr = createMarkerLocal [format ["%1-%2",text _x, position _x], position _x];
	if (type _x in _lowPriority) then {
		_mkr setMarkerSizeLocal [0.8,0.8];
	};
	if (type _x in _midPriority) then {
		_mkr setMarkerSizeLocal [1,1];
	};
	if (type _x in _highPriority) then {
		_mkr setMarkerSizeLocal [1.5,1.5];
	};

	// Set the allegiance of the location 
    _allegiance = "North";
	_mkr setMarkerType "vn_flag_pavn";
    if ((position _x) inArea "SouthAO") then {
        _allegiance = selectRandomWeighted ["USA", 0.5, "ROK", 0.3, "AUS", 0.2, "NZ", 0.1];
    };
	if ((position _x) inArea "Base") then {
		_allegiance = "USA";
	};

	switch (_allegiance) do {
		case "USA": {_mkr setMarkerType "vn_flag_usa";};
		case "ROK": {_mkr setMarkerType "vn_flag_arvn";};
		case "AUS": {_mkr setMarkerType "vn_flag_aus";};
		case "NZ": {_mkr setMarkerType "vn_flag_nz";};
	};

	// Build forces in the location 
	// initial force presence 
	_infantryGroupsCount = (round (random 10)) + _priority;
	
	// Build Ambushes 
	_location = _x;
	if (_allegiance == "North") then {
		_ambushCount = round (random 10) + _priority;
		for "_i" from 1 to _ambushCount do {
			_ambushType = selectRandom ["Road", "Trail", "Mount"];
			_pos = [];
			switch (_ambushType) do {
				case "Road": {
					_pos = selectRandom (nearestTerrainObjects [position _location, [_ambushType], 1500, false, true]);
					_pos = position _pos;
				};
				case "Trail": {
					_pos = selectRandom (nearestTerrainObjects [position _location, [_ambushType], 1500, false, true]);
					_pos = position _pos;
				};
				case "Mount": {
					_pos = selectRandom (nearestLocations [position _location, [_ambushType], 1500]);
					_pos = position _pos;
				};
			};
			_countOfTroops = (round (random [1, 3, 5])) + _priority;
			_hasEmplacement = selectRandomWeighted [true, 0.3, false, 0.7];
			_hasMine = selectRandomWeighted [true, 0.3, false, 0.7];

			// Create a marker 
			_mkr = createMarker [format ["Ambush-%1", _pos], _pos];
			_mkr setMarkerType "HD_Objective";
			_mkr setMarkerText "Ambush";
			_mkr setMarkerAlpha 0;
			_ambush = [_ambushType, _pos, _countOfTroops, _hasEmplacement, _hasMine];

			// Setup a trigger 
			_trg = createTrigger ["EmptyDetector", _pos, true];
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_trg setTriggerArea [250, 250, 0, false, 100];
			_trg setVariable ["ambush", _ambush];
			_trg setVariable ["ambushID", _i];
			_trg setVariable ["attachedLocation", _location];
			_trg setTriggerStatements[
				"this",
				"[thisTrigger] remoteExec ['lmn_fnc_spawnAmbush', 2]",
				"[thisTrigger] remoteExec ['lmn_fnc_despawnAmbush', 2]"
			];

			// Save to DB 
			["write", [_location, format ["Ambush-%1", _i], _ambush]] call _locDB;
		};
	};

	// Build Turrets 
	if (_allegiance == "North") then {
		_turrets = (round (random 5)) + _priority;
		for "_i" from 1 to _turrets do {
			_spawnPos = [position _location, 10, 1000, 15, 0, 5] call BIS_fnc_findSafePos;
			_turret = [selectRandom (lmn_PAVN select 3), _spawnPos];

			// Create a trigger on the enemy turret 
			_trg = createTrigger ["EmptyDetector", position _location];
			_trg setTriggerArea [1500, 1500, 0, false, 800];
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_trg setVariable ["turretID", _i];
			_trg setVariable ["attachedLocation", _location];
			_trg setTriggerStatements [
				"this",
				"[thisTrigger] remoteExec ['lmn_fnc_spawnTurret', 2]",
				""
			];

			// Save to DB 
			["write", [_location, format ["Turret-%1", _i], _turret]] call _locDB;
		};
	};

    // Create a Trigger on the location 
	_trg = createTrigger ["EmptyDetector", position _x];
	_trg setTriggerArea [800, 800, 0, false, 400];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setVariable ["attachedLocation", _x];
	_trg setVariable ["Active", false];
	_trg setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_ActivateLoc', 2]",
		"thisTrigger setVariable ['Active', false]"
	];

	// Save the location 
	["write", [_x, "Name", text _x]] call _locDB;
	["write", [_x, "Pos", position _x]] call _locDB;
	["write", [_x, "Priority", _priority]] call _locDB;
    ["write", [_x, "Allegiance", _allegiance]] call _locDB;
	["write", [_x, "InfantryGroups", _infantryGroupsCount]] call _locDB;
} forEach _locations;

systemChat "[DB] Locations Generated";