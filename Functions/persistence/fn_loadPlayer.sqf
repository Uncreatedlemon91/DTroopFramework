// Load the player from the database 
params ["_player"];

_uid = getplayeruid _player;
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

_data = ["read", [_uid, "Player Info"]] call _db;
// systemChat format ["%1", _data];
_pos = _data select 1;
_dir = _data select 2;
_loadout = _data select 4;
_medical = _data select 5;

_player setPosAtl _pos;
_player setDir _dir;
_player setUnitLoadout _loadout;
[_player, _medical] call ace_medical_fnc_deserializeState;

systemChat format ["Welcome back %1", (_data select 0)];
