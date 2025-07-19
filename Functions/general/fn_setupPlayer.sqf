// Sets up the player with event handlers and such 
params ["_player"];

// Event Handlers 
_player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

_player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

_player addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

_player addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

_player addEventHandler ["InventoryOpened", {
	params ["_unit", "_primaryContainer", "_secondaryContainer"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

_player addEventHandler ["MagazineReloading", {
	params ["_unit", "_weapon", "_muzzle", "_magazine", "_magazineClass", "_ammoCount", "_magazineID", "_magazineCreator"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];
