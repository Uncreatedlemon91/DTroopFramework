// Creates a Battalion 
params ["_faction", "_location"];

// Get the current database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// Get location database
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Create variables for the battalion
_id = (count _sections) + 1;
_name = "";
_type = "";
_composition = [];
_mapMarker = "";
_veterancy = selectRandom [
	0.5,
	0.6,
	0.7,
	0.8,
	0.9,
	1
];
_posture = "Staging";
_position = ["read", [_location, "Position"]] call _locDB;

// Update variables 
switch (_faction) do {
	case "USA": {
		_type = selectRandom ["Infantry", "Armor"];
		_name = format ["%1 Battalion, %2th %3 Regiment", round (random 4), round (Random 200), _type];
		switch (_type) do {
			case "Infantry": {
				_composition = [
					[configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01", 32],
					[configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_08", 1]
				];
				_mapMarker = "b_inf";
			 };
			case "Armor": {
				_composition = [
					[configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_armor_army" >> "vn_b_group_armor_army_02", 5],
					[configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_armor_army" >> "vn_b_group_armor_army_07", 4],
					[configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01", 15]
				];
				_mapMarker = "b_armor";
			};
		};
	};
	case "PAVN": {
		_type = selectRandom ["Infantry", "Special Forces"];
		_name = format ["%1 Battalion, %2th %3 Regiment", selectRandom ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"], selectRandom ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"], _type];
		switch (_type) do {
			case "Infantry": {
				_composition = [
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva" >> "vn_o_group_men_nva_01", 30],
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva" >> "vn_o_group_men_nva_04", 10],
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva" >> "vn_o_group_men_nva_07", 5],
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_motor_nva_65" >> "vn_o_group_motor_nva_65_01", 5],
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_motor_nva_65" >> "vn_o_group_motor_nva_65_03"5]
				];
				_mapMarker = "o_inf";
			};
			case "Special Forces": {
				_composition = [
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_01", 15],
					[configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_02", 10]
				];
				_mapMarker = "o_recon";
			};
		};
	};
};

// Save to the data base 
["write", [_id, "Name", _name]] call _db;
["write", [_id, "Veterancy", _veterancy]] call _db;
["write", [_id, "Faction", _faction]] call _db;
["write", [_id, "Type", _type]] call _db;
["write", [_id, "Composition", _composition]] call _db;
["write", [_id, "MapMarker", _mapMarker]] call _db;
["write", [_id, "Posture", _posture]] call _db;
["write", [_id, "HQLocation", _location]] call _db;
["write", [_id, "Position", _position]] call _db;

// Create a trigger to represent the battalion on the map 
_trg = createTrigger ["EmptyDetector", _position];
_trg setTriggerArea [350, 350, 0, false, 200];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnBattalion', 2]",
	"thisTrigger setVariable ['lmnDeployed', false]"
];

// Add variables to the trigger 
_trg setVariable ["lmnBattalionID", _id];
_trg setVariable ["lmnFaction", _faction];
