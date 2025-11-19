// Ran to update the security level of a location 
params ["_locID", "_faction", "_difference"];

// get the database 
_db = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get current Security Level 
_currentSecurity = ["read", [_locID, "Security"]] call _db;
_newSecurity = 0;
// Update security level
switch (_faction) do {
	case "USA": {_newSecurity = _currentSecurity + _difference};
	case "PAVN": {_newSecurity = _currentSecurity - _difference};
};

// Sync Database
["write", [_locID, "Security", _newSecurity]] call _db;