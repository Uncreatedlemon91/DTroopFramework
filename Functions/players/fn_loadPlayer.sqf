// Load the player from the database 
params ["_data", "_player"];

_pos = _data select 0;
_dir = _data select 1;
_loadout = _data select 2;
_medical = _data select 3;
_kit = _data select 4;

_player setPosAtl _pos;
_player setDir _dir;
_player setUnitLoadout _loadout;
[_player, _medical] call ace_medical_fnc_deserializeState;

// Add ace variables based on kit 
// Define roles 
_medicalRoles = [];
_engineerRoles = ["Mechanic"];

if (_kit in _medicalRoles) then {
	_player setVariable ["ace_medical_medicclass", 1, true];
};

if (_kit in _engineerRoles) then {
	_player setVariable ["ace_isEngineer", 1, true];
};

systemChat format ["Welcome back %1", (name _player)];