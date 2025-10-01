params ["_veh"];

// Set Event Handlers 
_veh addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["GetOut", {
	params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
	[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	[_unit] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["ContainerOpened", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

_veh addEventHandler ["Killed", {
	params ["_unit", "_killer"];
	[_unit] remoteExec ["lmn_fnc_saveVehicle", 2];
}];

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
