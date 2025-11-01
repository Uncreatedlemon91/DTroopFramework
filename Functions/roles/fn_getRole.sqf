// Gets the players applies the selected loadout to the player. 
params ["_kit", "_player"];

// Check if the player has the role 
_hasRole = [_player, _kit] call lmn_fnc_getWhitelistedRoles;
if (_hasRole) exitWith {systemChat "You do not have this role unlocked!"};

// Get the loadout from the loadout character 
_loadout = getUnitLoadout _kit;

// Apply the loadout to the player 
_player setUnitLoadout _loadout; 

// Add the relevant variables 
_player setVariable ["CurrentKit", _kit];

// Save current loadout to the player's database profile 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_uid = getPlayerUID _player;
["write", [_uid, "Player Kit", _kit]] call _db;

// Notify the player of succesful kit change 
systemChat format ["%1 kit applied", _kit];