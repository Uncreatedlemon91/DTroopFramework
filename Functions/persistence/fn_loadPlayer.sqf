// Load the player from the database 
params ["_data", "_player"];

_pos = _data select 1;
_dir = _data select 2;
_loadout = _data select 4;
_medical = _data select 5;
_weapon = _data select 6;

_player setPosAtl _pos;
_player setDir _dir;
_player setUnitLoadout _loadout;
[_player, _medical] call ace_medical_fnc_deserializeState;
_player selectWeapon _weapon;

systemChat format ["Welcome back %1", (_data select 0)];