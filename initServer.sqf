// Add interaction items 
[] remoteExec ["lmn_fnc_addActions", 0, true];

// Add event handlers
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit"];
	[_unit] remoteExec ["lmn_fnc_savePlayer", 2];
}];

//// Load the save game 
// Recall Databases
_vehDB = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_itemDB = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;


// Check if the database exists 
_vehicleDatabaseExists = "exists" call _vehDB;
_locDBExists = "exists" call _locDB;
_itemDBExists = "exists" call _itemDB;

// Load the databases
if (_vehicleDatabaseExists) then {
    [] remoteExec ["lmn_fnc_loadVehicles", 2];
    systemChat "[DB] Vehicles Loaded";
};
if (_locDBExists) then {
    [] remoteExec ["lmn_fnc_loadLocations", 2];
    systemchat "[DB] Locations Loaded";
};
if (_itemDBExists) then {
    [] remoteExec ["lmn_fnc_loadItems", 2];
    systemchat "[DB] Items Loaded";
};