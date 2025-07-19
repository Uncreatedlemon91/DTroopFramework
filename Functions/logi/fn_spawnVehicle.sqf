// Spawn a vehicle of given classname near the logistics point 
params ["_class"];

// Spawn the vehicle 
_spawnPos = [position LogiPoint, 2, 20, 5, 0, 10, 0] call BIS_fnc_findSafePos;
_veh = _class createVehicle _spawnPos;

// Set Vehicle initial parameters 
_veh setDamage 0.2;
_veh setFuel 0.1;
_veh setDir (random 360);
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;

[_veh] remoteExec ["lmn_fnc_setupVehicle", 2];