// Adds the ACE interaction to the item 
params ["_item"];

// Create the category for Tier kits
_changeKit = [
    "Change Kit",
    "Change Kit",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;
[_item, 0, ["ACE_MainActions"], _changeKit] call ace_interact_menu_fnc_addActionToObject;

// Add Tier 0 Category
_tier0Category = [
    "Tier0",
    "Tier 0 Loadouts",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;
[_item, 0, ["ACE_MainActions", "Change Kit"], _tier0Category] call ace_interact_menu_fnc_addActionToObject;

// Add Tier 0 roles
_base = [
    "Base",
    "Base",
    "",
    {[Base, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_rifleman = [
    "Rifleman",
    "Rifleman",
    "",
    {[Rifleman, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_lat = [
    "LAT",
    "LAT",
    "",
    {[LAT, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_ar = [
    "AR",
    "AR",
    "",
    {[AR, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_mgasst = [
    "MG Asst",
    "MG Asst",
    "",
    {[MGAsst, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_crewchief = [
    "Crew Chief",
    "Crew Chief",
    "",
    {[CrewChief, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_mechanic = [
    "Mechanic",
    "Mechanic",
    "",
    {[Mechanic, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

_mg = [
    "MG",
    "Machine Gunner",
    "",
    {[MG, _player, _target] remoteExec ["lmn_fnc_getRole", 2];},
    {true}
] call ace_interact_menu_fnc_createAction;

// Add the roles to the actions
_Tier0roles = [_base, _rifleman, _lat, _ar, _mgasst, _crewchief, _mechanic, _mg];
{
    [_item, 0, ["ACE_MainActions", "Change Kit", "Tier0"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _Tier0roles;
