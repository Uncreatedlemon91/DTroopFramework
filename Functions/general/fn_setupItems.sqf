// Sets up saving mechanisms to the boxes 
params ["_box"];
systemChat "[DB] Setting up Box";

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

[_box, 0, ["ACE_MainActions"], _boxDelete] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];
[_box, 0, ["ACE_MainActions"], _boxSave] remoteExec ["ace_interact_menu_fnc_addActionToObject", 0, true];

// Event Handlers 
_box addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit] remoteExec ["lmn_fnc_saveItem", 2];
}];

_box addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveItem", 2];
}];

_box addEventHandler ["ContainerOpened", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveItem", 2];
}];

// Initial save of the item 
[_box] remoteExec ["lmn_fnc_saveItem", 2];