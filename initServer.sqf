//// Load the save game 
// Recall Databases
_vehDB = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_itemDB = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;
_envDB = ["new", format ["World Environment %1 %2", missionName, worldName]] call oo_inidbi;
_battDB = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// Check if the database exists 
_vehicleDatabaseExists = "exists" call _vehDB;
_locDBExists = "exists" call _locDB;
_itemDBExists = "exists" call _itemDB;
_envDBExists = "exists" call _envDB;
_battalionDatabaseExists = "exists" call _battDB;

// Load the databases
if (_locDBExists) then {
    [] remoteExec ["lmn_fnc_loadLocations", 2];
} else {
    [] remoteExec ["lmn_fnc_setupLocations", 2];
};
if (_itemDBExists) then {
    [] remoteExec ["lmn_fnc_loadItems", 2];
};
if (_envDBExists) then {
    [] remoteExec ["lmn_fnc_loadEnvironment", 2];
};
if (_vehicleDatabaseExists) then {
    [] remoteExec ["lmn_fnc_loadVehicles", 2];
};
if (_battalionDatabaseExists) then {
    [] remoteExec ["lmn_fnc_loadBattalions", 2];
};

// Add actions to items in map 
[LogiPoint] remoteExec ["lmn_fnc_addActionToItem", 0, true];

// Run ongoing Scripts 
[] remoteExec ["lmn_fnc_saveEnvironment", 2];
[] remoteExec ["lmn_fnc_timeManager", 2];

// Start Directors 
sleep 10;
[] remoteExec ["lmn_fnc_USdirector", 2];
[] remoteExec ["lmn_fnc_PAVNdirector", 2];

// Setup global EH's 
["ace_dragging_stoppedCarry", {
    params ["_unit", "_target", "_loadCargo"];
    [_target] remoteExec ["lmn_fnc_saveItem", 2];
}] call CBA_fnc_addEventHandler;

["ace_dragging_stoppedDrag", {
    params ["_unit", "_target"];
    [_target] remoteExec ["lmn_fnc_saveItem", 2];
}] call CBA_fnc_addEventHandler;

["ace_refuel_stopped", {
    params ["_source", "_target", "_nozzle"];
    [_target] remoteExec ["lmn_fnc_saveItem", 2];
    [_source] remoteExec ["lmn_fnc_saveItem", 2];
}] call CBA_fnc_addEventHandler;