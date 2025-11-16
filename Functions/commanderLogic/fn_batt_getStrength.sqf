// Checks the battalion strength and if they need reinforcements or not. 
params ["_batt"];

// Get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// Set Variables 
_infantry = ["read", [_batt, "Infantry Squads"]] call _db;
_tanks = ["read", [_batt, "Tank Squads"]] call _db;
_mechanized = ["read", [_batt, "Mechanized Squads"]] call _db;
_recon = ["read", [_batt, "Recon Squads"]] call _db;
_mortars = ["read", [_batt, "Mortar Squads"]] call _db;

// Check current strength against full strength 
if (_infantry select 0 < _infantry select 1) exitWith {
	// Need more infantry Squads 
	"Infantry Squads";
};

if (_tanks select 0 < _tanks select 1) then {
	// Need more infantry Squads 
	"Tank Squads";
};

if (_mechanized select 0 < _mechanized select 1) then {
	// Need more infantry Squads 
	"Mechanized Squads";
};

if (_recon select 0 < _recon select 1) then {
	// Need more infantry Squads 
	"Recon Squads";
};

if (_mortars select 0 < _mortars select 1) then {
	// Need more infantry Squads 
	"Mortar Squads";
};

"Full Size";