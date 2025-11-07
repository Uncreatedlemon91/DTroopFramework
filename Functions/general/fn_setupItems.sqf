// Sets up saving mechanisms to the boxes 
params ["_box"];

// Actions to save and delete 
_boxDelete = [
    "boxDelete", 
    "Delete", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target, "itemdb"] remoteExec ["lmn_fnc_deleteFromDatabase", 2];
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
        systemchat "Item Saved";
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Actions added to the box 
[_box, 0, ["ACE_MainActions"], _boxDelete] call ace_interact_menu_fnc_addActionToObject;
[_box, 0, ["ACE_MainActions"], _boxSave] call ace_interact_menu_fnc_addActionToObject;

// Setup ACE Stuff 
[_box, true, [0, 2, 0], 20] call ace_dragging_fnc_setDraggable;
[_box, true, [0, 3, 1], 10] call ace_dragging_fnc_setCarryable;
[_box, 1] call ace_cargo_fnc_setSize;
[_box, true, [0,3,1], 0, true, true] call ace_dragging_fnc_setCarryable;

if (typeof _box == "vn_b_ammobox_supply_04") then {
    [_box] remoteExec ["lmn_fnc_addActionToItem", 0, true];
};