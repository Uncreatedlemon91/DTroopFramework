// Load battalions from the database 
// get the database 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// Pull data and load it into the game
{
	_position = ["read", [_x, "Position"]] call _db;
	_faction = ["read", [_x, "Faction"]] call _db;
	_name = ["read", [_x, "Name"]] call _db;
	_mapMarker = ["read", [_x, "MapMarker"]] call _db;

	// Reset mission flags 
	["write", [_x, "NotOnSupplyMission", true]] call _db;

	_trg = [_position, _x, _faction, _mapMarker, _name] call lmn_fnc_setBattTrigger;

	// Run the logic for the Battalion
	[_x, _trg] remoteExec ["lmn_fnc_battalionLogic", 2];

	// Loop
	sleep 0.02;
} forEach _sections;