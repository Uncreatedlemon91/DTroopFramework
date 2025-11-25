// Prep the hashmaps
LemonActiveMarkers = createHashMap;
LemonLocations = createHashMap;
LemonBattalions = createHashMap;
LemonTaskOrders = createHashMap;

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

// Start Modules
[] remoteExec ["lmn_fnc_locationsLoad", 2];
[] remoteExec ["lmn_fnc_battalionLoad", 2];


// Save modules 
[] remoteExec ["lmn_fnc_battalionSave", 2];