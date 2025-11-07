// Supply box 
params ["_type"];

// Determine what box we're spawning to determine model and contents 
_model = "";
switch (_type) do {
	case "Resupply": {
		_model = "vn_b_ammobox_supply_04";
	};
	case "Wheels": {
		_model = "ACE_Wheel";
	};
	case "Helipad":{
		_model = "Land_vn_b_helipad_01";
	};
	case "Buffalo": {
		_model = "Land_vn_b_prop_m149";
	};
	case "radio": {
		_model = "Land_vn_radio";
	};
	case "fuelDrum": {
		_model = "Land_vn_b_prop_fueldrum_01";
	};
	case "target": {
		_model = "vn_targetp_inf_f";
	};
	case "Lamp": {
		_model = "Land_vn_lampshabby_f_4xdir_normal";
	};
	case "Lantern": {
		_model = "Land_vn_us_common_lantern_01";
	};
	case "Revetment": {
		_model = "Land_vn_usaf_revetment_01";
	};
	case "Sandbags": {
		_model = "Land_vn_bagfence_short_f";
	};
	case "Sandbags Rounded": {
		_model = "Land_vn_bagfence_round_f";
	};
};

// Spawn the box 
_box = _model createVehicle position itemspawn;

// Clear items it spawns with
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

// Event Handlers 
_box addEventHandler ["ContainerClosed", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveItem", 2];
}];

_box addEventHandler ["ContainerOpened", {
	params ["_container", "_unit"];
	[_container] remoteExec ["lmn_fnc_saveItem", 2];
}];

_box addEventHandler ["Killed", {
	params ["_unit", "_killer"];
	[_unit, "itemdb"] remoteExec ["lmn_fnc_deleteFromDatabase", 2];
}];

// Setup the box
[_box] remoteExec ["lmn_fnc_setupItems", 0, true];

