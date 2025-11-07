params ["_player", "_clientOwner"];

// Load player
_uid = getPlayerUID _player;
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

// Extract Data 
_pos = ["read", [_uid, "Position"]] call _db;
_dir = ["read", [_uid, "Direction"]] call _db;
_loadout = ["read", [_uid, "Loadout"]] call _db;
_medical = ["read", [_uid, "Medical"]] call _db;
_kit = ["read", [_uid, "Player Kit"]] call _db;

// Send data to the player
_data = [_pos, _dir, _loadout, _medical, _kit];
[_data, _player] remoteExec ["lmn_fnc_loadPlayer", _clientOwner];