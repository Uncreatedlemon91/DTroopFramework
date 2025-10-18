// Precompile the variables used in the mission 
[] call lmn_fnc_setFactions;
sleep 0.5;

//// Load the save game 
// Recall Databases
_vehDB = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_itemDB = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;
_treeDB = ["new", format ["Removed Trees %1 %2", missionName, worldName]] call oo_inidbi;
_envDB = ["new", format ["World Environment %1 %2", missionName, worldName]] call oo_inidbi;

// Check if the database exists 
_vehicleDatabaseExists = "exists" call _vehDB;
_locDBExists = "exists" call _locDB;
_itemDBExists = "exists" call _itemDB;
_treeDBExists = "exists" call _treeDB;
_envDBExists = "exists" call _envDB;

// Load the databases

if (_locDBExists) then {
    [] remoteExec ["lmn_fnc_loadLocations", 2];
    // systemchat "[DB] Locations Loading...";
} else {
    [] remoteExec ["lmn_fnc_setupLocations", 2];
    // systemChat "[DB] Generation Locations...";
};
if (_itemDBExists) then {
    [] remoteExec ["lmn_fnc_loadItems", 2];
};
if (_treeDBExists) then {
    [] remoteExec ["lmn_fnc_loadTrees", 2];
};
if (_envDBExists) then {
    [] remoteExec ["lmn_fnc_loadEnvironment", 2];
};
if (_vehicleDatabaseExists) then {
    [] remoteExec ["lmn_fnc_loadVehicles", 2];
};


// Run ongoing Scripts 
[] remoteExec ["lmn_fnc_saveEnvironment", 2];
[] remoteExec ["lmn_fnc_timeManager", 2];

while {true} do {
    // Run the War Director
    [] remoteExec ["lmn_fnc_wdTick", 2];
    sleep 14400; // 4 hour sleep
};