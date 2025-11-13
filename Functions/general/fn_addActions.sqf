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
    "Repair Truck",
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

_spawnPatrol = [
    "spawnPatrol", 
    "Spawn Patrol Jeep", 
    "", 
    {["vn_b_wheeled_m151_mg_03"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnAmbulance = [
    "spawnAmbulance", 
    "Spawn Ambulance", 
    "", 
    {["vn_b_armor_m577_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnCommand = [
    "spawnCommand", 
    "Spawn HQ", 
    "", 
    {["vn_b_armor_m577_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnM113 = [
    "spawnM113", 
    "Spawn M113A1", 
    "", 
    {["vn_b_armor_m113_01"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
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

_spawnCH47a = [
    "spawnch47a", 
    "Spawn CH47A", 
    "", 
    {["vn_b_air_ch47_03_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnCH47am = [
    "spawnch47am", 
    "Spawn CH47A-Medical", 
    "", 
    {["vn_b_air_ch47_02_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Boat Actions
_spawnBoats = [
    "spawnBoats",
    "Boats",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnNasty = [
    "spawnNasty", 
    "Spawn PTF Nasty", 
    "", 
    {["vn_b_boat_05_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_spawnPBR = [
    "spawnPBR", 
    "Spawn PBR", 
    "", 
    {["vn_b_boat_12_02"] remoteExec ["lmn_fnc_spawnVehicle", 2]}, 
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

_resupplyBox = [
    "Resupply",
    "Resupply Box",
    "",
    {["Resupply"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_wheels = [
    "Wheels",
    "Wheels",
    "",
    {["Wheels"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

// ITEMS TO SPAWN 
_items = [
    "items", 
    "Items", 
    "", 
    {}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_helipad = [
    "Helipad",
    "Helipad",
    "",
    {["Helipad"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_wBuffalo = [
    "Buffalo",
    "Buffalo",
    "",
    {["Buffalo"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_fuelDrum = [
    "fuelDrum",
    "Fuel Drum",
    "",
    {["fuelDrum"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_target = [
    "target",
    "Target",
    "",
    {["target"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_revetment = [
    "Revetment",
    "Revetment",
    "",
    {["Revetment"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_Sandbags = [
    "Sandbags",
    "Sandbags",
    "",
    {["Sandbags"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_SandbagsRounded = [
    "SandbagsRounded",
    "Sandbags Rounded",
    "",
    {["SandbagsRounded"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_Lamp = [
    "Lamp",
    "Lamp",
    "",
    {["Lamp"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

_Lantern = [
    "SLanternandbagsRounded",
    "Lantern",
    "",
    {["Lantern"] remoteExec ["lmn_fnc_spawnSupply", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;

// Add actions for roles 

// Addactions to logistics point
// Vehicles 
[ItemSpawner, 0, ["ACE_MainActions"], _spawnVehicles] call ace_interact_menu_fnc_addActionToObject;
// Utility
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle"], _spawnUtility] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnFuelTruck] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnAmmoTruck] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnUtility"], _spawnRepairTruck] call ace_interact_menu_fnc_addActionToObject;
// Transport
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle"], _spawnTransport] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnJeep] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnTruck] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnM113] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnAmbulance] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnPatrol] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnTransport"], _spawnCommand] call ace_interact_menu_fnc_addActionToObject;
// Helicopters
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle"], _spawnHeli] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnHuey1d] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnLoach] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnAh1g] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnCH47a] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnHeli"], _spawnCH47am] call ace_interact_menu_fnc_addActionToObject;
// Boats 
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle"], _spawnBoats] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnBoats"], _spawnNasty] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "spawnVehicle", "spawnBoats"], _spawnPBR] call ace_interact_menu_fnc_addActionToObject;
// Supplies 
[ItemSpawner, 0, ["ACE_MainActions"], _supplies] call ace_interact_menu_fnc_addActionToObject;
// Ammunition 
[ItemSpawner, 0, ["ACE_MainActions", "supplies"], _resupplyBox] call ace_interact_menu_fnc_addActionToObject;

// Items 
[ItemSpawner, 0, ["ACE_MainActions"], _items] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _helipad] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _wBuffalo] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _fuelDrum] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _target] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _revetment] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _Sandbags] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _SandbagsRounded] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _Lamp] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _Lantern] call ace_interact_menu_fnc_addActionToObject;
[ItemSpawner, 0, ["ACE_MainActions", "items"], _wheels] call ace_interact_menu_fnc_addActionToObject;
