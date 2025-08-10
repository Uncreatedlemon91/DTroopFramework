// Sets up a garrison site at a building 
params ["_trg", "_faction"];

_loc = _trg getVariable "attachedLocation";
_pos = position (selectRandom (nearestTerrainObjects [_trg, ["HOUSE", "HOSPITAL", "BUILDING", "BUNKER", "FORTRESS"], 500, false, false]));
_alpha = 0;

// Determine faction details 
_side = "";
_groupClass = [];
switch (_faction) do {
	case "USA": {
		_side = west; 
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_02"),
			(configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01")
		];
	};
	case "North": {
		_side = east;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_01"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_01"),
			(configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_65_field" >> "vn_o_group_men_nva_65_field_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_02"),
			(configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_01")
		];
	};
	case "AUS": {
		_side = west;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_68" >> "vn_b_group_men_aus_army_68_02")
		];
	};
	case "ROK": {
		_side = independent;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_01"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_army" >> "vn_i_group_men_army_02"),
			(configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_sf" >> "vn_i_group_men_sf_02")
		];
	};
	case "NZ": {
		_side = west;
		_groupClass = selectRandom [
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_01"),
			(configfile >> "CfgGroups" >> "West" >> "VN_NZ" >> "vn_b_group_men_nz_army_68" >> "vn_b_group_men_nz_army_68_02")
		];
	};
};

// Setup a Marker
_mkr = createMarker [format ["%1-%2", _trg, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORBLACK";
_mkr setMarkerAlpha _alpha;

// Setup the Trigger 
_garrisonTrg = createTrigger ["EmptyDetector", _pos];
_garrisonTrg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_garrisonTrg setTriggerArea [500, 500, 0, false, 500];
_garrisonTrg setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnGarrison', 2];",
	""
];
_garrisonTrg setVariable ["Active", false];
_garrisonTrg setVariable ["FactionSide", _side];
_garrisonTrg setVariable ["attachedLocation", _loc];
_garrisonTrg setVariable ["ToSpawn", _groupClass];