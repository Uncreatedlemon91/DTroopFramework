// Spawns an ambush for the player. 
params ["_trg"];

// Determine faction details 
_side = "";
_faction = _trg getVariable "faction";
_groupClass = [];
switch (_faction) do {
	case "USA": {
		_side = west; 
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_03"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_static_army" >> "vn_b_group_static_army_11"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_static_army" >> "vn_b_group_static_army_10")
		];
	};
	case "North": {
		_side = east;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_01"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_01"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_03"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_04"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_04"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_03"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_01")
		];
	};
	case "AUS": {
		_side = west;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_03"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_05")
		];
	};
	case "ROK": {
		_side = independent;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_01"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_02"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_03"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_sf" >> "vn_i_group_men_sf_02")
		];
	};
	case "NZ": {
		_side = west;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_03")
		];
	};
};

// Make the unit  
_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["TREE", "BUSH"], 50, false, false]));
_grp = [_pos, _side, _groupClass] call BIS_fnc_spawnGroup;

{
	// Current result is saved in variable _x
	// Check for nearby players 
	[_x, _trg] remoteExec ["lmn_fnc_despawnAI", 2];
} forEach units _grp;

// Give the unit orders to defend the point  
[_grp, position _trg] call BIS_fnc_taskDefend;
