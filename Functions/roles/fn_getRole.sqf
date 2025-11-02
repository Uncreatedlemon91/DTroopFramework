// Gets the players applies the selected loadout to the player. 
params ["_kit", "_player"];

// Check if the player has the role 
//_hasRole = [_player, _kit] call lmn_fnc_getPlayerWhitelistedRoles;
//if !(_hasRole) exitWith {["You do not have this role unlocked!"] remoteExec ["systemChat", netId _player]};
systemChat format ["Kit: %1", _kit];
// Get the loadout from the loadout character 
_loadout = getUnitLoadout _kit;

// Apply the loadout to the player 
_player setUnitLoadout _loadout; 

// Add the relevant variables 
_player setVariable ["CurrentKit", _kit];

// Save current loadout to the player's database profile 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_uid = getPlayerUID _player;
["write", [_uid, "Player Kit", str _kit]] call _db;