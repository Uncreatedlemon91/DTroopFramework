// This function acts as the tactical commander of the AI forces in an area. 
params ["_trig"];

// Kill script if the trigger is one of these things: 
_isActive = _trig getVariable "Activated";
if (_isActive) exitWith {systemChat "[TD] Already Active!"};

// Change the trigger to 'active'
_trig setVariable ["Activated", true, true];

// Spawn the ambient life modules 
// [_trig] remoteExec ["lmn_fnc_spawnCivilian", 2];

// Loop while it is activated 
while {_trig getVariable "Activated"} do {
	// Get update database entry 
	_db = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	_data = ["read", [(_trig getVariable "Location"), "Data"]] call _db;

	// Get list of players in the trigger area
	_players = list _trig;
	_playerCount = count _players;

	// Gather forcepool data 
	_troopCount = _data select 3;
	_siteType = _data select 6;
	_faction = _data select 2;
	_activeTroops = _trig getVariable ["ActiveTroops", []];

	// Confirm that this script should be working
	_noSpawn = false;
	if (_troopCount <= 0) then {
		systemChat "[TD] NO MORE TROOPS!";
		_noSpawn = true;
		_newFaction = "";
		if ((_faction == "USA") OR (_faction == "ARVN")) then {
			_newFaction = "PAVN";
		};
		if (_faction == "PAVN") then {
			_newFaction = selectRandom ["USA", "ARVN"];
		};
		_loc = nearestLocation [position _trig, _siteType];
		systemChat format ["Loc: %1", _loc];
		_mkr = _trig getVariable "Marker";
		deleteVehicle _trig;
		deleteMarker _mkr;
		[_loc, _newFaction] remoteExec ["lmn_fnc_createLocation", 2];  // Convert this location 
	};
	if (count _activeTroops > _troopCount) then {systemChat "[TD] All forces are deployed!"; _noSpawn = true};
	if (count _activeTroops > (_playerCount * 8)) then {systemChat "[TD] More forces than players in the AO!"; _noSpawn = true};

	// Continue with script
	if (_noSpawn) then {} else {
		// Actions to take 
		_Ambush = 1;
		_defend = 1;
		_attack = 1;
		_patrol = 1;
		_hunt = 1;

		switch (_siteType) do {
			case "NameLocal": {_defend = _defend + 2; _patrol = _patrol + 1};
			case "nameVillage": {_defend = _defend + 1; _patrol = _patrol + 2};
			case "Name": {_attack = _attack + 2; _patrol = _patrol + 1};
			case "VegetationBroadleaf": {_patrol = _patrol + 2; _ambush = _ambush + 3; _hunt = _hunt + 3};
			case "Hill": {_ambush = _ambush + 2; _patrol = _patrol + 1; _hunt = _hunt + 3};
			case "NameMarine": {_attack = _attack + 2; _defend = _defend + 1};
			case "ViewPoint": {_ambush = _ambush + 1; _patrol = _patrol + 2};
			case "Strategic": {_attack = _attack + 2; _defend = _defend + 2};
			case "NameCity": {_defend = _defend + 2; _patrol = _patrol + 1};
			case "Airport": {_attack = _attack + 1; _defend = _defend + 3};
			case "StrongpointArea": {_defend = _defend + 3; _patrol = _patrol + 1; _hunt = _hunt + 3};
			case "NameCityCapital": {_defend = _defend + 3; _attack = _attack + 1};
		};

		// Add a factor based on player count 
		if (_playerCount < 3) then {
			_ambush = _ambush + 2;
			_patrol = _patrol + 1;
			_hunt = _hunt + 3;
		};
		if (_playerCount >= 4) then {
			_Attack = _attack + 2;
			_defend = _defend + 2;
		};

		// Add a factor for troop count in the region 
		if (count _activeTroops < 10) then {
			_defend = _defend + 2;
			_ambush = _ambush + 1;
		};

		// Add a factor based on closest players 
		_targetRandomPlayer = selectRandom _players;
		_dist = _targetRandomPlayer distance (_data select 1);
		if (_dist > 600) then {
			_ambush = _ambush + 5;
			_hunt = _hunt + 3;
		};
		
		// Decide action based on random weighted values
		_action = selectRandomWeighted [
			"Ambush", _ambush,
			"Hunt", _hunt,
			"Defend", _defend,
			"Attack", _attack,
			"Patrol", _patrol
		];

		// Decide how many forces to send / engage with 
		switch (_action) do {
			case "Ambush": {[_data, "Ambush", _trig] remoteExec ["lmn_fnc_tdSpawnTroops", 2]};
			case "Defend": {[_data, "Defend", _trig] remoteExec ["lmn_fnc_tdSpawnTroops", 2]};
			case "Attack": {[_data, "Attack", _trig] remoteExec ["lmn_fnc_tdSpawnTroops", 2]};
			case "Patrol": {[_data, "Patrol", _trig] remoteExec ["lmn_fnc_tdSpawnTroops", 2]};
			case "Hunt": {[_data, "Hunt", _trig] remoteExec ["lmn_fnc_tdSpawnTroops", 2]};
		};
	};

	// Loop the script  
	sleep 60;
};

// Deactivate the trigger 
// Despawn trigger units 
_trig setVariable ["Activated", false, true];
_activeTroops = _trig getVariable ["ActiveTroops", []];
{
	if (vehicle _x != _x) then {
		deleteVehicle (vehicle _x);
	};
	deleteVehicle _x;
	sleep 0.02;
} forEach _activeTroops;
_trig setVariable ["ActiveTroops", [], true];

// Debug
systemChat "[WD] Tactical Director Deactivated";
