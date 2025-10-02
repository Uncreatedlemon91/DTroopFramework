params ["_veh"];

// Actions to save and delete 
_vehDelete = [
    "boxDelete", 
    "Delete", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target, "vehdb"] remoteExec ["lmn_fnc_deleteFromDatabase", 2];
	},
    {true}
] call ace_interact_menu_fnc_createAction;

_vehSave = [
    "boxSave", 
    "Save", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_target] remoteExec ["lmn_fnc_saveVehicle", 2];
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

[_veh, 0, ["ACE_MainActions"], _vehDelete] call ace_interact_menu_fnc_addActionToObject;
[_veh, 0, ["ACE_MainActions"], _vehSave] call ace_interact_menu_fnc_addActionToObject;

if (typeOf _veh == "vn_b_armor_m577_02") then {
	_veh setVariable ["ace_medical_isMedicalVehicle", true, true];
};
