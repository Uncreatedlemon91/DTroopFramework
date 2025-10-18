// Tactical commander that directs an Ambush assault 
params ["_trig"];

// Gather forcepool data 
_troopCount = _trig getVariable "TroopCount";

// Get list of players in the trigger area
_players = list _trig;
_playerCount = count _players;
systemChat format ["[TD] Players in Area: %1", _playerCount];

// Decide how many forces to send / engage with
_troopsToSend = random [_playerCount, _playerCount + 5, _playerCount + 10];
if !((_troopsToSend > 0) AND (_troopsToSend <= _troopCount)) exitWith {
	systemChat "[TD] Not enough troops to execute Ambush.";
};

// Reduce the troop count in the trigger
_newTroopCount = _troopCount - _troopsToSend;
_trig setVariable ["TroopCount", _newTroopCount, true];

// Execute Ambush
systemChat format ["[TD] Executing Ambush at %1 with %2 troops", _trig getVariable "Location", _troopsToSend];

// Select faction 
_faction = _trig getVariable "Faction";
_spawnFaction = "";
_spawnSide = "";
switch (_faction) do {
	case "USA": {_spawnFaction = lmn_US; _spawnSide = west};
	case "PAVN": {_spawnFaction = lmn_PAVN; _spawnSide = east};
	case "ARVN": {_spawnFaction = lmn_ARVN; _spawnSide = independent};
};
_troopGroup = createGroup _spawnSide;
_troopGroup deleteGroupWhenEmpty true;

// Select the troops to send 
for "_i" from 1 to _troopsToSend do {
	// Select troop type 
	_troopType = selectRandomWeighted [
		(_spawnFaction select 0), 5,
		(_spawnFaction select 1), 3
	];
	_troopModel = selectRandom _troopType;

	// Create the troop 
	_spawnPos = _trig getVariable "Location" findEmptyPosition [0,50,5];
	_troopUnit = _troopGroup createUnit [_troopModel, _spawnPos, [], 0, "FORM"];

	sleep 0.1;
};

// Assign a mission to the troops 
_tasking = selectRandom ["ambushCreep", "ambushRush"];
switch (_tasking) do {
	case "ambushCreep": {[_troopUnit, position player, 20] spawn lambs_wp_fnc_taskCreep};
	case "ambushRush": {[_troopUnit, position player, 20] spawn lambs_wp_fnc_taskRush};
};

// Add group level event handlers to reduce Troop Count on casualties 