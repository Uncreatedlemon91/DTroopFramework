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
			"vn_b_army_static_m45"
		];
	};
	case "North": {
		_side = east;
		_class = selectRandom [
			"vn_o_nva_static_dshkm_high_02",
			"vn_o_nva_static_sgm_high_01",
			"vn_o_nva_static_zgu1_01",
			"vn_o_nva_static_zpu4",
			"vn_sa2"
		];
	};
	case "AUS": {
		_side = west;
		_class = selectRandom [
			"vn_b_army_static_m45"
		];
	};
	case "ROK": {
		_side = independent;
		_class = selectRandom [
			"vn_i_static_m45"
		];
	};
	case "NZ": {
		_side = west;
		_class = selectRandom [
			"vn_b_army_static_m45"
		];
	};
};

// Setup Marker
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORYELLOW";
_mkr setMarkerAlpha _alpha;

// Setup the Trigger 
_aaSite = createTrigger ["EmptyDetector", _pos];
_aaSite setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_aaSite setTriggerArea [2000, 2000, 0, false, 500];
_aaSite setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnAA', 2];",
	"thisTrigger setVariable ['Activated', false]"
];
_aaSite setVariable ["Activated", false];
_aaSite setVariable ["FactionSide", _side];
_aaSite setVariable ["attachedLocation", _loc];
_aaSite setVariable ["ToSpawn", _class];