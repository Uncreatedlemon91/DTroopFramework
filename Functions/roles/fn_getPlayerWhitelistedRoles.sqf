// Checks for the player's whitelisted roles on the server database 
params ["_player", "_kit"];

// Get the database 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

// Get the player's information 
_uid = getPlayerUID _player;
_whitelistedRoles = ["read", [_uid, "Whitelisted", []]] call _db;

// Check if the kit is in whitelisted roles 
_hasRole = false;
if (_kit in _whitelistedRoles) then {
	_hasRole = true; 
};

_hasRole;