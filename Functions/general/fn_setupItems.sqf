// Sets up saving mechanisms to the boxes 
params ["_box"];

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

[_box, 0, ["ACE_MainActions"], _boxDelete] call ace_interact_menu_fnc_addActionToObject;
[_box, 0, ["ACE_MainActions"], _boxSave] call ace_interact_menu_fnc_addActionToObject;

// Setup ACE Stuff 
[_box, true, [0, 2, 0], 20] call ace_dragging_fnc_setDraggable;
[_box, true, [0, 3, 1], 10] call ace_dragging_fnc_setCarryable;
if (typeOf _box == "Land_vn_tent_mash_01_02") then {
	_box setVariable ["ace_medical_isMedicalVehicle", true, true];
};

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