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

	[_position, _x, _faction, _mapMarker, _name] remoteExec ["lmn_fnc_setBattTrigger", 2];

	// Load the commander for the battalion 
	[_x] remoteExec ["lmn_fnc_logicUS", 2];
	sleep 0.02;
} forEach _sections;