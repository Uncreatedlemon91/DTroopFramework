// Set Variables 
_uid = getPlayerUID player;

// Start player persistence.
[_uid] remoteExec ["lmn_fnc_playerPersistence", 2];

// Add player event handlers
player addMPEventHandler ["MPRespawn", {
	params ["_unit", "_corpse"];
	[_unit, _corpse] remoteExec ["lmn_fnc_handleDeath", 2];
}];

player addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	_bulletsFired = _unit getVariable "BulletsFired";
	_fired = _bulletsFired + 1;
	_bulletsfired = _unit setVariable ["BulletsFired", _fired];
}];