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

