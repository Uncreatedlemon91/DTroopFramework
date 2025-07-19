// save the player character 
params ["_player"];

// Setup databases for Wrecks and Player vehicles 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

// Get details
_pos = getPosATL _player;
_dir = getDir _player;
_uid = getPlayerUID _player;
_name = name _player;
_loadout = getUnitLoadout _player;
_medical = [_player] call ace_medical_fnc_serializeState;

// Save to database
_data = [_name, _pos, _dir, _uid, _loadout, _medical];
["write", [_uid, "Player Info", _data]] call _db;