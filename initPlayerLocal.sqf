// Set Variables 
_uid = getPlayerUID player;

// Start player persistence.
[_uid] remoteExec ["lmn_fnc_playerPersistence", 2];

// Add player event handlers
player addMPEventHandler ["MPRespawn", {
	params ["_unit", "_corpse"];
	[_unit, _corpse] remoteExec ["lmn_fnc_handleDeath", 2];
}];

