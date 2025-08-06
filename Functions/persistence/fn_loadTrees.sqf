// Loads all hidden trees and re-hides them. 
_db = ["new", format ["Removed Trees %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// apply saved vehicle locations back to the server 
{
	_data = ["read", [_x, "Position"]] call _db;

	_tree = (nearestTerrainObjects [_data, ["TREE"], 5, true, false]) select 0;
	hideObjectGlobal _tree;
} forEach _sections;
