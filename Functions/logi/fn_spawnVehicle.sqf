// Spawn a vehicle of given classname near the logistics point 
params ["_class"];

// Spawn the vehicle 
_veh = _class createVehicle position itemspawn;

// Set Vehicle initial parameters 
_veh setDamage 0.2;
_veh setFuel 0.1;
_veh setDir (random 360);
_veh setVehicleAmmo 0;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

[_veh] remoteExec ["lmn_fnc_setupVehicle", 2];