// Sets up saving mechanisms to the boxes 
params ["_box"];

// Event Handlers 
_box addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit] remoteExec ["lmn_fnc_saveBox", 2];
}];

_box addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveBox", 2];
}];

_box addEventHandler ["ContainerOpened", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveBox", 2];
}];

// Actions to save and delete 
_boxDelete = [
    "boxDelete", 
    "Delete", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["lmn_fnc_deleteItem", 2];
	},
    {true}
] call ace_interact_menu_fnc_createAction;

_boxSave = [
    "boxSave", 
    "Save", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["lmn_fnc_saveItem", 2];
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;