// save the player character 
params ["_player", "_uid"];

// Setup databases for Wrecks and Player vehicles 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

// Get details
_pos = getPosATL _player;
_dir = getDir _player;
_name = name _player;
_loadout = getUnitLoadout _player;
_medical = [_player] call ace_medical_fnc_serializeState;

if (isNil "_uid") then {
	_uid = getPlayerUID _player;
};

// Save to database
["write", [_uid, "Name", _name]] call _db;
["write", [_uid, "UID", _uid]] call _db;
["write", [_uid, "Position", _pos]] call _db;
["write", [_uid, "Direction", _dir]] call _db;
["write", [_uid, "Loadout", _loadout]] call _db;
["write", [_uid, "Medical", _medical]] call _db;