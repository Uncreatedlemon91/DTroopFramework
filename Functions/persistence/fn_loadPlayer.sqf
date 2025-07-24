// Load the player from the database 
params ["_data"];

_data = ["read", [_uid, "Player Info"]] call _db;
_pos = _data select 1;
_dir = _data select 2;
_loadout = _data select 4;
_medical = _data select 5;

_player setPosAtl _pos;
_player setDir _dir;
_player setUnitLoadout _loadout;
[_player, _medical] call ace_medical_fnc_deserializeState;

systemChat format ["Welcome back %1", (_data select 0)];
