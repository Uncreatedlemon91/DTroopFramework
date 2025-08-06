// Prepares AA sites within the location 
params ["_trg", "_faction"];

_loc = _trg getVariable "attachedLocation";
_pos = position (selectRandom ((nearestTerrainObjects [_trg, ["ROAD", "TRAIL", "MAIN ROAD"], 500, false, false])+([position _trg, 0, 400, 10, 0, 10, 0] call BIS_fnc_findSafePos;)));

// Setup the AA Site 
_side = "";
_class = [];

switch (_faction) do {
	case "USA": {
		_side = west; 
		_class = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_03"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_static_army" >> "vn_b_group_static_army_11"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_static_army" >> "vn_b_group_static_army_10")
		];
	};
	case "North": {
		_side = east;
		_class = selectRandom [
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
		_class = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_03"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_05")
		];
	};
	case "ROK": {
		_side = independent;
		_class = selectRandom [
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_01"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_02"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_03"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_sf" >> "vn_i_group_men_sf_02")
		];
	};
	case "NZ": {
		_side = west;
		_class = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_03")
		];
	};
};

// Setup Marker
_mkr = createMarker [format ["%1-%2", _trg, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORYELLOW";

// Setup the Trigger 
_aaSite = createTrigger ["EmptyDetector", _pos];
_aaSite setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_aaSite setTriggerArea [1200, 1200, 0, false, 1200];
_aaSite setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnAA', 2];",
	""
];
_aaSite setVariable ["Active", false];
_aaSite setVariable ["FactionSide", _side];
_aaSite setVariable ["attachedLocation", _loc];
_aaSite setVariable ["ToSpawn", _class];
