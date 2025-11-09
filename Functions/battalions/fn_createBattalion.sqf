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
_posture = "Reserve";
_position = ["read", [_location, "Position"]] call _locDB;

// Update variables 
switch (_faction) do {
	case "USA": {
		_type = selectRandom ["Infantry", "Armor"];
		_name = format ["%1 Battalion, %2th %3 Regiment", round (random 4) + 1, round (Random 200) + 1, _type];
		switch (_type) do {
			case "Infantry": {
				_composition = [
					["Infantry Squad", 12],
					["Recon Squad", 4]
				];
				_mapMarker = "b_inf";
			 };
			case "Armor": {
				_composition = [
					["Infantry Squad", 6],
					["Tank Squad", 4],
					["Mechanized Squad", 4]
				];
				_mapMarker = "b_armor";
			};
		};
	};
	case "PAVN": {
		_type = selectRandom ["Infantry", "Special Forces"];
		_name = format ["%1 Battalion, %2th %3 Regiment", round (random 4) + 1, round (Random 200) + 1, _type];
		switch (_type) do {
			case "Infantry": {
				_composition = [
					["Infantry Squad", 12],
					["Recon Squad", 4]
				];
				_mapMarker = "o_inf";
			};
			case "Special Forces": {
				_composition = [
					["Infantry Squad", 12],
					["Recon Squad", 4]
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

// Create the trigger
[_position, _id, _faction] call lmn_fnc_setBattTrigger;