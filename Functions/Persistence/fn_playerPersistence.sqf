// Saves and loads the player to the server. Likely using the server profile
params ["_uid"];

// Set Variables 
_unit = _uid call BIS_fnc_getUnitByUid;
_lives = 5;
_saveLoop = 15;

// Get data of the player, if it exists 
_data = missionProfileNamespace getVariable [format ["%1-%2", _uid, missionName], []];
_firedData = missionProfileNameSpace getVariable [format ["%1-%2-BulletsFired", _uid, missionname], 0];

// Database administration
if (resetBulletCounts) then {
	_firedData = missionProfileNameSpace setVariable [format ["%1-%2-BulletsFired", _uid, missionName], 0];
};
if (resetPlayerData) then {
	_data = missionProfileNameSpace setVariable [format ["%1-%2", _uid, missionName], nil];
};

// Load the player 
_unit setPosATL (_data select 0);
_unit setDir (_data select 1);
_unit setUnitLoadout (_data select 2);
_unit setVariable ["livesLeft", _data select 3];
_medicalState = (_data select 4);
[_unit, _medicalState] call ace_medical_fnc_deserializeState
_unit setVariable ["BulletsFired", _firedData];
systemChat "Player Loaded";

sleep 5;
// Initiate Save loop 
while {true} do {
	sleep _saveLoop;
	_unit = _uid call BIS_fnc_getUnitByUid;
	_pos = getPosATL _unit;
	_dir = getDir _unit;
	_loadout = getUnitLoadout _unit;
	_livesLeft = _unit getVariable ["livesLeft", _lives];
	_medicalState = [_unit] call ace_medical_fnc_serializeState;
	_bulletsFired = _unit getVariable ["BulletsFired", 0];

	// Setup package to save
	_data = [_pos, _dir, _loadout, _livesLeft, _medicalState];
	missionProfileNamespace setVariable [format ["%1-%2", _uid, missionName], _data];
	missionProfileNamespace setVariable [format ["%1-%2-BulletsFired", _uid, missionName], _bulletsFired];
	saveMissionProfileNamespace;
};