[] remoteExec ["lmn_fnc_addActions", 0, true];

// Load the save game 
// Vehicles 
_vehicleDatabase = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_vehicleDatabaseExists = "exists" call _vehicleDatabase;
if (_vehicleDatabaseExists) then {
    [] remoteExec ["lmn_fnc_loadVehicles", 2];
};

// Locations 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locDBExists = "exists" call _locDB;
if (_locDBExists) then {
    [] remoteExec ["lmn_fnc_loadLocations", 2];
    systemchat "[DB] Locations Loaded";
} else {
    [] remoteExec ["lmn_fnc_CreateLocations", 2];
    systemchat "[DB] Locations Created";
};
