params ["_player", "_clientOwner"];

// Check if dead 
_uid = getplayeruid _player;
_time = systemTime;
_dd = _time select 2;
_mm = _time select 1;
_yy = _time select 0;
_newTime = format ["%1-%2-%3", _mm, _dd, _yy];
_Ddb = ["new", format ["Player Deaths %1 %2", missionName, worldName]] call oo_inidbi;
_isDead = ["read", [_uid, _newTime]] call _Ddb;

// Load player
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_data = ["read", [_uid, "Player Info"]] call _db;
[_data, _player, _isDead] remoteExec ["lmn_fnc_loadPlayer", _clientOwner];