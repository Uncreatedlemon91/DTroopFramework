// Add actions to interactable items 

// Create Actions
_spawnUtility = [
    "spawnUtility",
    "Utility",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnFuelTruck = [
    "spawnFuelTruck",
    "Fuel Truck",
    "",
    {["vn_b_wheeled_m151_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnJeep = [
    "spawnJeep", 
    "Spawn Jeep", 
    "", 
    {["vn_b_wheeled_m151_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Addactions to logistics point
[logiPoint, 0, ["ACE_MainActions"], _spawnUtility] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnUtility"], _spawnJeep] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnUtility"], _spawnFuelTruck] call ace_interact_menu_fnc_addActionToObject;