// Add actions to interactable items 

// Add addactions to Logistics
_spawnJeep = [
    "spawnJeep", 
    "Spawn Jeep", 
    "", 
    {["vn_b_wheeled_m151_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;



[logiPoint, 0, ["ACE_MainActions"], _spawnJeep] call ace_interact_menu_fnc_addActionToObject;
