// This the logistics commander. 
// It will look for logistical needs and generate tasks for the players to complete as well as 
// dispatching it's own AI units. 

// Create the database 
_db = ["new", format ["Logistics %1 %2", missionName, worldName]] call oo_inidbi;
_usResources = ["read", ["Resources", "US", "None"]] call _db;
_arvnResources = ["read", ["Resources", "ARVN", "None"]] call _db;
_nvaResources = ["read", ["Resources", "NVA", "None"]] call _db;

// If the database is empty, then create it 
if (_usResources == "None") then {
	["write", ["Resources", "US", random 100]] call _db;
	["write", ["Resources", "ARVN", random 100]] call _db;
	["write", ["Resources", "NVA", random 100]] call _db;
};

// Get the supply levels from the sites on the map 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locDB;
_usSupply = 0;
_arvnSupply = 0;
_nvaSupply = 0;
_prioritized = [];
{
	// Get Data from the objective
	_data = ["read", [_x, "Data"]] call _locDB;
	_supply = _data select 5;
	_faction = _data select 2;
	_flagSize = _data select 9;
	switch (_faction) do {
		case "USA": {_usSupply = _usSupply + _supply};
		case "ARVN": {_arvnSupply = _arvnSupply + _supply};
		case "PAVN": {_nvaSupply = _nvaSupply + _supply};
	};

	// Set if the location should be prioritized
	if (_flagSize > 1) then {
		_prioritized pushback _x;
	} else {
		_nonPrioritized pushback _x;
	};

	// Sleep to loop script
	sleep 0.02;
} forEach _locs;