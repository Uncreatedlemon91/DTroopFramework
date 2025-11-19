// Ran to update the security level of a location 
params ["_locID", "_faction", "_difference"];

// get the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get current Security Level 
_currentSecurity = ["read", [_locID, "Security"]] call _db;

// Update security level
switch (_faction) do {
	case "USA": {["write", [_locID, "Security", _currentSecurity + _difference]] call _db};
	case "PAVN": {["write", [_locID, "Security", _currentSecurity - _difference]] call _db};
};