params ["_player", "_clientOwner"];

_uid = getplayeruid _player;
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_data = ["read", [_uid, "Player Info"]] call _db;
[_data] remoteExec ["lmn_fnc_loadPlayer", _clientOwner];