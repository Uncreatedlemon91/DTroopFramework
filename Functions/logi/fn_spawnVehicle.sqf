// Spawn a vehicle of given classname near the logistics point 
params ["_class"];

// Spawn the vehicle 
_pos = [position itemspawn, 0, 100, 10, 0, 10, 0] call BIS_fnc_findSafePos; 
_veh = _class createVehicle _pos;

// Set Vehicle initial parameters 
_veh setDamage 0.2;
_veh setFuel 0.1;
_veh setDir (random 360);
_veh setVehicleAmmo 0;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

// Setup Event Handlers 
_veh addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["GetOut", {
	params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
	[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["ContainerOpened", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["Killed", {
	params ["_unit", "_killer"];
	[_unit] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

[_veh] remoteExec ["lmn_fnc_setupVehicle", 2];