_db = ["new", format ["Player Wrecks %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// Debug
// apply saved vehicle locations back to the server 
{
	_data = ["read", [_x, "Wreck Info"]] call _db;
	_pos = _data select 0;
	_type = _data select 1;
	_dir = _data select 2;

	// Spawn vehicle replica 
	_veh = _type createVehicle _pos;
	_veh setDir _dir;
	_veh setDamage [1, false, objNull, objNull];

	["deleteSection", _x] call _db;
	[_veh] remoteExec ["lmn_fnc_saveWreck", 2];
} forEach _sections;

