// Adds the ACE interaction to the item 
params ["_item"];

// Create the action 
_action = [
    "LoadoutKit",
    "Change Loadout",
    "",
    {["Rifleman", _player] remoteExec ["lmn_fnc_getRole", 2]},
    {true}
] call ace_interact_menu_fnc_createAction;