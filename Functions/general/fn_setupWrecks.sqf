// Sets up saving mechanisms to the boxes 
params ["_wreck"];

// Actions to save and delete 
_boxDelete = [
    "boxDelete", 
    "Delete", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["lmn_fnc_deleteWreck", 2];
	},
    {true}
] call ace_interact_menu_fnc_createAction;

_boxSave = [
    "boxSave", 
    "Save", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["lmn_fnc_saveWreck", 2];
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

[_wreck, 0, ["ACE_MainActions"], _boxDelete] call ace_interact_menu_fnc_addActionToObject;
[_wreck, 0, ["ACE_MainActions"], _boxSave] call ace_interact_menu_fnc_addActionToObject;

_wreck setVariable ["Loaded", true, true];