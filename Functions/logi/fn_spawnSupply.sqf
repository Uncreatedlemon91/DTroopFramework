// Supply box 
params ["_type"];

// Determine what box we're spawning to determine model and contents 
_model = "";
_content = [];
switch (_type) do {
	case "M16Ammo": {
		_model = "vn_b_ammobox_02"; 
		_content = [
			["vn_m16_20_mag", 50],
			["vn_m16_20_t_mag", 50]
		];
	};
	case "M60Ammo": {
		_model = "vn_b_ammobox_02"; 
		_content = [
			["vn_m60_100_mag", 30],
			["ACE_SpareBarrel", 5]
		];
	};
	case "M79Ammo": {
		_model = "vn_b_ammobox_04";
		_content = [
			["vn_40mm_m381_he_mag", 40],
			["vn_40mm_m397_ab_mag", 20],
			["vn_40mm_m406_he_mag", 20],
			["vn_40mm_m433_hedp_mag", 20],
			["vn_40mm_m576_buck_mag", 20],
			["vn_40mm_m583_flare_w_mag", 20],
			["vn_40mm_m651_cs_mag", 20],
			["vn_40mm_m661_flare_g_mag", 20],
			["vn_40mm_m662_flare_r_mag", 20],
			["vn_40mm_m690_smoke_w_mag", 20],
			["vn_40mm_m682_smoke_r_mag", 20],
			["vn_40mm_m715_smoke_g_mag", 20],
			["vn_40mm_m716_smoke_y_mag", 20],
			["vn_40mm_m716_smoke_p_mag", 20]
		];
	};
	case "Grenades": {
		_model = "vn_b_ammobox_04";
		_content = [
			["vn_m67_grenade_mag", 25],
			["vn_m18_white_mag", 20],
			["vn_m18_green_mag", 20],
			["vn_m18_red_mag", 20],
			["vn_m18_purple_mag", 20],
			["vn_m18_yellow_mag", 20],
			["vn_m34_grenade_mag", 20],
			["vn_m14_grenade_mag", 20]
		];
	};
	case "Medical": {
		_model = "ACE_medicalSupplyCrate";
		_content = [
			["ACE_elasticBandage", 50],
			["ACE_packingBandage", 50],
			["ACE_quickClot", 50],
			["ACE_bodybag", 20],
			["ACE_epinephrine", 20],
			["ACE_morphine", 20],
			["ACE_personalAidKit", 20],
			["ACE_SurgicalKit", 5],
			["ACE_suture", 20],
			["ACE_splint", 20],
			["ACE_tourniquet", 50]
		];
	};
	case "Fluids": {
		_model = "ACE_medicalSupplyCrate";
		_content = [
			["ACE_salineIV", 15],
			["ACE_salineIV_250", 15],
			["ACE_salineIV_500", 15]
		];
	};
	case "Tools": {
		_model = "vn_b_ammobox_04";
		_content = [
			["vn_b_item_toolkit", 10],
			["ACE_EntrenchingTool", 10],
			["ACE_Flashlight_MX991", 10],
			["ACE_Clacker", 10],
			["ACE_MapTools", 10],
			["acex_intelitems_notepad", 10],
			["ACE_wirecutter", 10],
			["ACE_artilleryTable", 10],
			["ACE_DefusalKit", 10]
		];
	};
	case "Wheels": {
		_model = "ACE_Wheel";
		_content = [];
	};
	case "Helipad":{
		_model = "Land_vn_b_helipad_01";
		_content = [];
	};
	case "Buffalo": {
		_model = "Land_vn_b_prop_m149";
		_content = [];
	};
	case "radio": {
		_model = "Land_vn_radio";
		_content = [];
	};
	case "fuelDrum": {
		_model = "Land_vn_b_prop_fueldrum_01";
		_content = [];
	};
	case "target": {
		_model = "vn_targetp_inf_f";
		_content = [];
	};
	case "Lamp": {
		_model = "Land_vn_lampshabby_f_4xdir_normal";
		_content = [];
	};
	case "Lantern": {
		_model = "Land_vn_us_common_lantern_01";
		_content = [];
	};
	case "Revetment": {
		_model = "Land_vn_usaf_revetment_01";
		_content = [];
	};
	case "Sandbags": {
		_model = "Land_vn_bagfence_short_f";
		_content = [];
	};
	case "Sandbags Rounded": {
		_model = "Land_vn_bagfence_round_f";
		_content = [];
	};
	case "GL Ammo": {
		_model = "Land_WoodenCrate_01_F";
		_content = [
			["vn_40mm_m716_smoke_y_mag", 25],
			["vn_40mm_m661_flare_g_mag", 25],
			["vn_40mm_m680_smoke_w_mag", 25],
			["vn_40mm_m651_cs_mag", 25],
			["vn_40mm_m397_ab_mag", 25],
			["vn_40mm_m433_hedp_mag", 25],
			["vn_40mm_m662_flare_r_mag", 25],
			["vn_40mm_m715_smoke_g_mag", 25],
			["vn_40mm_m381_he_mag", 25],
			["vn_40mm_m406_he_mag", 25],
			["vn_40mm_m576_buck_mag", 25],
			["vn_40mm_m695_flare_y_mag", 25],
			["vn_40mm_m583_flare_w_mag", 25],
			["vn_40mm_m717_smoke_p_mag", 25],
			["vn_40mm_m682_smoke_r_mag", 25]
		];
	};
	case "Radios": {
		_model = "Land_PlasticCase_01_small_black_F";
		_content = [
			["B_simc_rajio_flak_1", 5]
		];
	};
	case "radioTower": {
		_model = "TFAR_Land_Communication_F";
		_content = []
	};
	case "PersonalBox": {
		_model = "Land_WoodenCrate_01_F";
		_content = [];
	};
	case "Ropes": {
		_model = "ACE_fastropingSupplyCrate";
		_content = [
			["ACE_rope12", 5],
			["ACE_rope15", 5],
			["ACE_rope18", 5],
			["ACE_rope27", 5],
			["ACE_rope3", 5],
			["ACE_rope36", 5],
			["ACE_rope6", 5]
		];
	};
	case "Explosives": {
		_model = "Land_WoodenCrate_01_F";
		_content = [
			["vn_mine_m18_fuze10_mag", 10],
			["vn_mine_m18_range_mag", 10],
			["vn_mine_m18_mag", 10],
			["vn_mine_m18_x3_range_mag", 10],
			["vn_mine_m18_x3_mag", 10],
			["vn_mine_m18_wp_fuze10_mag", 10],
			["vn_mine_m18_wp_range_mag", 10],
			["vn_mine_m18_wp_mag", 10],
			["vn_mine_m14_mag", 10],
			["vn_mine_m15_mag", 10]
		];
	};
	case "LauncherAmmo": {
		_model = "Land_WoodenCrate_01_F";
		_content = [
			["vn_m72_mag", 10],
			["vn_m20a1b1_heat_mag", 5],
			["vn_m20a1b1_wp_mag", 5]
		];
	};
};

// Spawn the box 
_box = _model createVehicle position itemspawn;;

// Clear items it spawns with
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

// Add desired contents to the box 
{
	//_box addMagazineCargoGlobal _x;
	_box addItemCargoGlobal _x;
	//_box addWeaponCargoGlobal _x;
} forEach _content;

// Setup the box
[_box] remoteExec ["lmn_fnc_setupItems", 0, true];