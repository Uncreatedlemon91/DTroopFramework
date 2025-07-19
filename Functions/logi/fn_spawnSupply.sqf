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
			["vn_m60_100_mag", 30]
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
		_model = "vn_b_ammobox_10";
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
			["ACE_adenosine", 10],
			["ACE_elasticBandage", 50],
			["ACE_packingBandage", 50],
			["ACE_quickClot", 50],
			["ACE_bloodIV", 15],
			["ACE_bloodIV_250", 15],
			["ACE_bloodIV_500", 15],
			["ACE_bodybag", 20],
			["ACE_epinephrine", 20],
			["ACE_morphine", 20],
			["ACE_personalAidKit", 20],
			["ACE_plasmaIV", 15],
			["ACE_plasmaIV_250", 15],
			["ACE_plasmaIV_500", 15],
			["ACE_SurgicalKit", 5],
			["ACE_suture", 20],
			["ACE_tourniquet", 50]
		];
	};
	default { };
};

// Spawn the box 
_spawnPos = [position LogiPoint, 2, 20, 5, 0, 10, 0] call BIS_fnc_findSafePos;
_box = _model createVehicle _spawnPos;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

// Add desired contents to the box 
{
	_box addMagazineCargoGlobal _x;
} forEach _content;

// Setup the box
[_box] remoteExec ["lmn_fnc_setupItem", 2];

