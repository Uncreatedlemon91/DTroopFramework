// Saves and loads the player to the server. Likely using the server profile
params ["_uid"];

// Set Variables 
_unit = _uid call BIS_fnc_getUnitByUid;
_lives = 5;

// Get data of the player, if it exists 
_data = missionProfileNamespace getVariable [format ["%1-%2", _uid, missionName], [[], 0, "", _lives]];

// Load the player 
_unit setPosATL (_data select 0);
_unit setDir (_data select 1);
_unit setUnitLoadout (_data select 2);
_unit setVariable ["livesLeft", _data select 3];
systemChat "Player Loaded";

sleep 5;
// Initiate Save loop 
while {true} do {
	sleep 10;
	_unit = _uid call BIS_fnc_getUnitByUid;
	_pos = getPosATL _unit;
	_dir = getDir _unit;
	_loadout = getUnitLoadout _unit;
	_livesLeft = _unit getVariable ["livesLeft", _lives];
	_data = [_pos, _dir, _loadout, _livesLeft];
	missionProfileNamespace setVariable [format ["%1-%2", _uid, missionName], _data];
	saveMissionProfileNamespace;
};