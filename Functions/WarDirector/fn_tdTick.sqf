// This function acts as the tactical commander of the AI forces in an area. 
params ["_trig"];

// Kill script if the trigger is already activated
if (_trig getVariable ["Activated", true]) exitWith {};

// Trigger is not activated, proceed
// List the trigger to activated
_trig setVariable ["Activated", true]; 

while {true} do {
	// Gather forcepool data 
	_troopCount = _trig getVariable "TroopCount";
	_siteType = _trig getVariable "SiteType";
	_faction = _trig getVariable "Faction";

	// Actions to take 
	_Ambush = 0;
	_defend = 0;
	_attack = 0;
	_patrol = 0;

	switch (_siteType) do {
		case "mount": {_ambush = _ambush + 2; _patrol = _patrol + 1};
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

	// Decide action based on random weighted values
	_action = selectRandomWeighted [
		"Ambush", _ambush,
		"Defend", _defend,
		"Attack", _attack,
		"Patrol", _patrol
	];

	// Decide how many forces to send / engage with 
	switch (_action) do {
		case "Ambush": {[_trig] remoteExec ["lmn_fnc_tdAmbush", 2]};
		case "Defend": {[_trig] remoteExec ["lmn_fnc_tdDefend", 2]};
		case "Attack": {[_trig] remoteExec ["lmn_fnc_tdAttack", 2]};
		case "Patrol": {[_trig] remoteExec ["lmn_fnc_tdPatrol", 2]};
	};

	// Wait for next tick 
	sleep 300;
};

