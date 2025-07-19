// Load the player from the database 
params ["_player"];

_uid = getplayeruid _player;
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

_data = ["read", [_uid, "Player Info"]] call _db;
if (isNil "_data") then {
	_player setPosAtl (_data select 1);
	_player setDir (_data select 2);
	_player setUnitLoadout (_data select 4);
	[_player, (_data select 5)] call ace_medical_fnc_deserializeState;

	systemChat format ["Welcome back %1", (_data select 0)];
} else {
	[player] remoteExec ["lmn_fnc_savePlayer", 2];
	systemChat format ["Welcome to the Server %1, your profile is created!", name player];
};
