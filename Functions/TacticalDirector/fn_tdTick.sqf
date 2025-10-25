// This function acts as the tactical commander of the AI forces in an area. 
params ["_trig"];

// Kill script if the trigger is one of these things: 
_isActive = _trig getVariable "Activated";
if (_isActive) exitWith {systemChat "[TD] Already Active!"};

// Change the trigger to 'active'
_trig setVariable ["Activated", true, true];

// Spawn the ambient life modules 
[_trig] remoteExec ["lmn_fnc_spawnCivilian", 2];

// Loop while it is activated 
while {_trig getVariable "Activated"} do {
	// Get list of players in the trigger area
	_players = list _trig;
	_playerCount = count _players;

	// Gather forcepool data 
	_troopCount = _trig getVariable "TroopCount";
	_siteType = _trig getVariable "SiteType";
	_faction = _trig getVariable "Faction";
	_loc = _trig getVariable "Location";

	// Confirm that this script should be working
	_noSpawn = false;
	_troopCount = _trig getVariable "TroopCount";
	_activeTroops = _trig getVariable ["ActiveTroops", []];
	if (_troopCount <= 0) exitWith {systemChat "[TD] NO MORE TROOPS!"}; // Convert this location 
	if ((count _activeTroops) >= _troopCount) then {systemChat "[TD] All forces are deployed!"; _noSpawn = true};

	if (_noSpawn) then {} else {
		// Actions to take 
		_Ambush = 1;
		_defend = 1;
		_attack = 1;
		_patrol = 1;

		switch (_siteType) do {
			case "NameLocal": {_defend = _defend + 2; _patrol = _patrol + 1};
			case "nameVillage": {_defend = _defend + 1; _patrol = _patrol + 2};
			case "Name": {_attack = _attack + 2; _patrol = _patrol + 1};
			case "VegetationBroadleaf": {_patrol = _patrol + 2; _ambush = _ambush + 3};
			case "Hill": {_ambush = _ambush + 2; _patrol = _patrol + 1};
			case "NameMarine": {_attack = _attack + 2; _defend = _defend + 1};
			case "ViewPoint": {_ambush = _ambush + 1; _patrol = _patrol + 2};
			case "Strategic": {_attack = _attack + 2; _defend = _defend + 2};
			case "NameCity": {_defend = _defend + 2; _patrol = _patrol + 1};
			case "Airport": {_attack = _attack + 1; _defend = _defend + 3};
			case "StrongpointArea": {_defend = _defend + 3; _patrol = _patrol + 1};
			case "NameCityCapital": {_defend = _defend + 3; _attack = _attack + 1};
		};

		// Add a factor based on player count 
		if (_playerCount < 3) then {
			_ambush = _ambush + 2;
			_patrol = _patrol + 1;
		};
		if (_playerCount >= 4) then {
			_Attack = _attack + 2;
			_defend = _defend + 2;
		};

		// Add a factor for troop count in the region 
		if ((count _activeTroops) < 10) then {
			_defend = _defend + 2;
			_ambush = _ambush + 1;
		};
		
		// Decide action based on random weighted values
		_action = selectRandomWeighted [
			"Ambush", _ambush,
			"Defend", _defend,
			"Attack", _attack,
			"Patrol", _patrol
		];

		// Decide how many forces to send / engage with 
		switch (_action) do {
			case "Ambush": {[_trig, _playerCount] remoteExec ["lmn_fnc_tdAmbush", 2]};
			case "Defend": {[_trig, _playerCount] remoteExec ["lmn_fnc_tdDefend", 2]};
			case "Attack": {[_trig, _playerCount] remoteExec ["lmn_fnc_tdAttack", 2]};
			case "Patrol": {[_trig, _playerCount] remoteExec ["lmn_fnc_tdPatrol", 2]};
		};
		
		// Sync the database 
		[_loc, _trig] remoteExec ["lmn_fnc_saveLocation", 2];
	};

	// Loop the script  
	sleep 30;
};

// Deactivate the trigger 
// Despawn trigger units 
_activeUnits = _trig getVariable ["ActiveUnits", []];
{
	if (vehicle _x != _x) then {
		deleteVehicle (vehicle _x);
	};
	deleteVehicle _x;
	sleep 0.02;
} forEach _activeUnits;

// Debug
systemChat "[WD] Tactical Director Deactivated";
_trig setVariable ["Activated", false, true];