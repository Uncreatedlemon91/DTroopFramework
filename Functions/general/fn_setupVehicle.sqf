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
        systemChat "Vehicle Saved";
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

_vehID = [
    "vehID",
    "VehicleID", 
    "",
    {
        params ["_target", "_player", "_params"];
        _id = _target getvariable "IndexVar";
        systemChat format ["Vehicle ID: %1", _id];
    }
] call ace_interact_menu_fnc_createAction;

[_veh, 0, ["ACE_MainActions"], _vehDelete] call ace_interact_menu_fnc_addActionToObject;
[_veh, 0, ["ACE_MainActions"], _vehSave] call ace_interact_menu_fnc_addActionToObject;
[_veh, 0, ["ACE_MainActions"], _vehID] call ace_interact_menu_fnc_addActionToObject;

// Vehicle specific settings
if ((typeOf _veh == "vn_b_armor_m577_02") OR (typeOf _veh == "vn_b_air_ch47_02_02")) then {
	_veh setVariable ["ace_medical_isMedicalVehicle", true, true];
};

if (typeOf _veh == "vn_b_air_ch47_03_02") then {
    [_veh, 24] call ace_cargo_fnc_setSpace;
};