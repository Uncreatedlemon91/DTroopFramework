// Creates a new military formation during mission runtime.
params ["_db", "_subUnits", "_type", "_commanderType", "_skill"];

// setup the battalion 
_name = format ["%1 %2 Battalion", round (random 200), _type];

// Save to the database 
["write", [_name, "Name", _name]] call _db;
["write", [_name, "Type", _type]] call _db;
["write", [_name, "Commander", _commanderType]] call _db;
["write", [_name, "Skill", _skill]] call _db;
["write", [_name, "SubUnits", _subUnits]] call _db;

// Sub Units 
switch (_type) do {
	case "Infantry": { };
	default { };
};

for "_i" from 1 to _subUnits do {
	// Setup sub unit  
	_coyName = format ["%1 Company - %2", _i, _name];
	_coyGroups = round (random [3,5,6]);
	
}