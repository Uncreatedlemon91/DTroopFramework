// Load the player from the database 
params ["_data", "_player", "_markers", "_kit"];

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

// Add markers to map 
{
	// Current result is saved in variable _x
	// _markerName,  _markerType, _markerAlpha, _markerColor, _markerText, _markerPos
	_mkr = createMarkerLocal [_x select 0, _x select 5];
	_mkr setMarkerTypeLocal (_x select 1);
	_mkr setMarkerAlphaLocal (_x select 2);
	_mkr setMarkerColorLocal (_x select 3);
	_mkr setMarkerText (_x select 4);
	sleep 0.01;	
} forEach _markers;
systemChat format ["Welcome back %1", (_data select 0)];