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

// Loop the locations
{
	_location = ["read", [_x, "Location"]] call _locDB;
	_trig = nearestObject [position _location, "EmptyDetector"];

	// Get existing variables 
	_supplyLevel = _trig getVariable "SupplyLevel";
	_troopLevel = _trig getVariable "TroopLevel";
	_maxTroopCount = _trig getVariable "MaxTroopCount";
	_faction = _trig getVariable "Faction";

	// Find nearby locations 
	_nearTrigs = nearestObjects [position _trig, ["EmptyDetector"], 1500, true];
	{
		// Grab near location's details 
		_trigTroopLevel = _x getVariable "TroopLevel";
		_trigMaxTroopLevel = _x getVariable "MaxTroopCount";
		_trigFaction = _x getVariable "Faction";

		// Make decision to move troops 
		if (_faction == _trigFaction) then {
			// Look to send troops 
			if ((_troopLevel > _trigTroopLevel) AND (_trigTroopLevel < _trigMaxTroopLevel) AND (_troopLevel > 30)) exitwith {
				[_trig, _x] remoteExec ["lmn_fnc_ldSendTroops", 2];
			};
		};
		
	} forEach _nearTrigs;
} forEach _locs;