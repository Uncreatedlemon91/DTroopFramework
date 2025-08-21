// Prepares AA sites within the location 
params ["_loc", "_faction", "_locPos"];

_pos = [_locPos, 0, 1000, 20, 0, 10, 0] call BIS_fnc_findSafePos;
_alpha = 0;

// Setup the AA Site 
_side = "";
_class = [];

switch (_faction) do {
	case "USA": {
		_side = west; 
		_class = selectRandom [
			"vn_b_army_static_mortar_m29",
			"vn_b_army_static_mortar_m2",
			"vn_b_army_static_m101_02"
		];
	};
	case "North": {
		_side = east;
		_class = selectRandom [
			"vn_o_nva_static_d44_01",
			"vn_o_nva_static_h12",
			"vn_o_nva_static_mortar_type63",
			"vn_o_nva_static_mortar_type53"
		];
	};
	case "AUS": {
		_side = west;
		_class = selectRandom [
			"vn_b_aus_army_static_m101_02",
			"vn_b_aus_army_static_mortar_m29",
			"vn_b_aus_army_static_mortar_m2"
		];
	};
	case "ROK": {
		_side = independent;
		_class = selectRandom [
			"vn_i_static_m101_02",
			"vn_i_static_mortar_m29",
			"vn_i_static_mortar_m2"
		];
	};
	case "NZ": {
		_side = west;
		_class = selectRandom [
			"vn_b_nz_army_static_m101_02",
			"vn_b_nz_army_static_mortar_m2",
			"vn_b_nz_army_static_mortar_m29"
		];
	};
};

// Setup Marker
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORBLUE";
_mkr setMarkerAlpha _alpha;


// Setup the Trigger 
_aaSite = createTrigger ["EmptyDetector", _pos];
_aaSite setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_aaSite setTriggerArea [2000, 2000, 0, false, 500];
_aaSite setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnArty', 2];",
	"thisTrigger setVariable ['Activated', false]"
];
_aaSite setVariable ["Activated", false];
_aaSite setVariable ["FactionSide", _side];
_aaSite setVariable ["attachedLocation", _loc];
_aaSite setVariable ["ToSpawn", _class];
