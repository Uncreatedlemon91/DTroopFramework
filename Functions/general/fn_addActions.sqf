// Add actions to interactable items 

// Create Actions
//// Vehicle Actions
_spawnVehicles = [
    "spawnVehicle",
    "Vehicles",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

// Utility Actions
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
    {["vn_b_wheeled_m54_fuel"] remoteExec ["lmn_fnc_spawnVehicle", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnAmmoTruck = [
    "spawnAmmoTruck",
    "Ammo Truck",
    "",
    {["vn_b_wheeled_m54_ammo"] remoteExec ["lmn_fnc_spawnVehicle", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnRepairTruck = [
    "spawnRepairTruck",
    "Ammo Truck",
    "",
    {["vn_b_wheeled_m54_repair"] remoteExec ["lmn_fnc_spawnVehicle", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

// Transport Actions 
_spawnTransport = [
    "spawnTransport",
    "Transport",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnJeep = [
    "spawnJeep", 
    "Spawn Jeep", 
    "", 
    {["vn_b_wheeled_m151_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnTruck = [
    "spawnTruck", 
    "Spawn Truck", 
    "", 
    {["vn_b_wheeled_m54_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Helicopter Actions 
_spawnHeli = [
    "spawnHeli",
    "Helicopters",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnHuey1d = [
    "spawnHuey1d", 
    "Spawn Huey", 
    "", 
    {["vn_b_air_uh1d_02_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnLoach = [
    "spawnLoach", 
    "Spawn Loach", 
    "", 
    {["vn_b_air_oh6a_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnAh1g = [
    "spawnCobra", 
    "Spawn Cobra", 
    "", 
    {["vn_b_air_ah1g_09"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// ------ Supplies 
// Ammunition Supplies 
_supplies = [
    "supplies", 
    "Supplies", 
    "", 
    {}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_m16Box = [
    "m16Box", 
    "M16 Ammo Box", 
    "", 
    {["m16Box"] remoteExec ["lmn_fnc_spawnSupply", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Addactions to logistics point
// Vehicles 
[logiPoint, 0, ["ACE_MainActions"], _spawnVehicles] call ace_interact_menu_fnc_addActionToObject;
// Utility
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle"], _spawnUtility] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnFuelTruck] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnAmmoTruck] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnRepairTruck] call ace_interact_menu_fnc_addActionToObject;
// Transport
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle"], _spawnTransport] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnJeep] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnTruck] call ace_interact_menu_fnc_addActionToObject;
// Helicopters
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle"], _spawnHeli] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnHuey1d] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnLoach] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnAh1g] call ace_interact_menu_fnc_addActionToObject;
// Supplies 
[logiPoint, 0, ["ACE_MainActions"], _supplies] call ace_interact_menu_fnc_addActionToObject;
// Ammunition 
[logiPoint, 0, ["ACE_MainActions", "supplies"], _infantry] call ace_interact_menu_fnc_addActionToObject;
[logiPoint, 0, ["ACE_MainActions", "supplies", "infantry"], _rifleman] call ace_interact_menu_fnc_addActionToObject;
