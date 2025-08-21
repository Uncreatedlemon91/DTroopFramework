params ["_player", "_clientOwner"];

// Load player
_uid = getPlayerUID _player;
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_data = ["read", [_uid, "Player Info"]] call _db;
[_data, _player] remoteExec ["lmn_fnc_loadPlayer", _clientOwner];