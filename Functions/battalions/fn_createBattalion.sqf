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
_infantrySquads = 10;
_tankSquads = 0;
_mechanizedSquads = 3;
_reconSquads = 2;
_mortarSquads = 2;
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
				_infantrySquads = 10;
				_tankSquads = 0;
				_mechanizedSquads = 3;
				_reconSquads = 2;
				_mortarSquads = 2;
				_mapMarker = "b_inf";
			 };
			case "Armor": {
				_infantrySquads = 5;
				_tankSquads = 4;
				_mechanizedSquads = 2;
				_reconSquads = 3;
				_mortarSquads = 1;
				_mapMarker = "b_armor";
			};
		};
	};
	case "PAVN": {
		_type = selectRandom ["Infantry", "Special Forces"];
		_name = format ["%1 Battalion, %2th %3 Regiment", round (random 4) + 1, round (Random 200) + 1, _type];
		switch (_type) do {
			case "Infantry": {
				_infantrySquads = 10;
				_tankSquads = 0;
				_mechanizedSquads = 3;
				_reconSquads = 2;
				_mortarSquads = 2;
				_mapMarker = "o_inf";
			};
			case "Special Forces": {
				_infantrySquads = 10;
				_tankSquads = 0;
				_mechanizedSquads = 3;
				_reconSquads = 2;
				_mortarSquads = 2;
				_mapMarker = "o_recon";
			};
		};
	};
};

_forceSize = _infantrySquads + _tankSquads + _mechanizedSquads + _reconSquads + _mortarSquads;

// Save to the data base 
["write", [_id, "Name", _name]] call _db;
["write", [_id, "Veterancy", _veterancy]] call _db;
["write", [_id, "Faction", _faction]] call _db;
["write", [_id, "Type", _type]] call _db;
["write", [_id, "Infantry Squads", _infantrySquads]] call _db;
["write", [_id, "Tank Squads", _tankSquads]] call _db;
["write", [_id, "Mechanized Squads", _mechanizedSquads]] call _db;
["write", [_id, "Recon Squads", _reconSquads]] call _db;
["write", [_id, "Mortar Squads", _mortarSquads]] call _db;
["write", [_id, "MapMarker", _mapMarker]] call _db;
["write", [_id, "Posture", _posture]] call _db;
["write", [_id, "Position", _position]] call _db;
["write", [_id, "CurrentForceSize", _forceSize]] call _db;
["write", [_id, "MaxForceSize", _forceSize]] call _db;

// Create the trigger
_trg = [_position, _id, _faction, _mapMarker, _name] call lmn_fnc_setBattTrigger;

// Run the logic for the Battalion
[_id, _trg, _faction] remoteExec ["lmn_fnc_battalionLogic", 2];