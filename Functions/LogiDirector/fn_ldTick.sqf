// This the logistics commander. 
// It will look for logistical needs and generate tasks for the players to complete as well as 
// dispatching it's own AI units. 

systemchat "[LD] - Starting Tick";

// Get the supply levels from the sites on the map 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locDB;

// Loop the locations
{
	SystemChat format ["[LD] %1" , _x];
	_data = ["read", [_x, "Data"]] call _locDB;

	// Get existing variables 
	_supplyLevel = _data select 5;
	_troopLevel = _data select 3;
	_maxTroopCount = _data select 4;
	_faction = _data select 2;
	_siteType = _data select 6;

	// PHASE ONE - Self Preservation 
	if ((_siteType == "Airport") AND (_faction == "USA")) then {
		// Add a mission to drop off troops and supplies 
		if (_troopLevel > _maxTroopCount) then {} else {
			_newTroopLevel = _troopLevel + round (random 100);
			_newSupplyLevel = _supplyLevel + round (random 100);
			_data set [3, _newTroopLevel];
			_data set [5, _newSupplyLevel];
			[_data] remoteExec ["lmn_fnc_saveLocation", 2];
		};	
	};

	if ((_siteType == "NameCity") AND (_faction == "PAVN")) then {
		// Add a mission to drop off troops and supplies 
		if (_troopLevel > _maxTroopCount) then {} else {
			_newTroopLevel = _troopLevel + round (random 100);
			_newSupplyLevel = _supplyLevel + round (random 100);
			_data set [3, _newTroopLevel];
			_data set [5, _newSupplyLevel];
			[_data] remoteExec ["lmn_fnc_saveLocation", 2];
		};		
	};

	if ((_siteType == "NameCity") AND (_faction == "ARVN")) then {
		// Add a mission to drop off troops and supplies 
		if (_troopLevel > _maxTroopCount) then {} else {
			_newTroopLevel = _troopLevel + round (random 100);
			_newSupplyLevel = _supplyLevel + round (random 100);
			_data set [3, _newTroopLevel];
			_data set [5, _newSupplyLevel];
			[_data] remoteExec ["lmn_fnc_saveLocation", 2];
		};	
	};

	// PHASE TWO - Interact with nearby locations 
	_nearLoc = selectRandom (_data select 0);
	_nearLocData = ["read", [text _nearLoc, "Data"]] call _locDB;
	_nearLocPos = _nearLocData select 1;
	_nearTrig = nearestObject [_nearLocPos, "EmptyDetector"];

	// Grab near location's details 
	_trigTroopLevel = _nearLocData select 3;
	_trigMaxTroopLevel = _nearLocData select 4;
	_trigFaction = _nearLocData select 2;

	// Other Location is friendly 
	if (_faction == _trigFaction) then {
		// Should we send troops to the other location?
		systemChat "Faction is the same";
		if ((_troopLevel > _trigTroopLevel) AND (_trigTroopLevel < _trigMaxTroopLevel) AND (_troopLevel > 30)) then {
			[_data, _nearLocData] remoteExec ["lmn_fnc_ldSendTroops", 2];
			systemChat "[LD] Sending Troops";
		};
	};

	// Other location is hostile 
	if (_faction != _trigFaction) then {
		systemChat "Factions are different!";
		if ((_faction == "PAVN") OR (_trigFaction == "PAVN")) then {
			// Assess an attack 
			if ((_troopLevel > _trigTroopLevel) AND (_troopLevel > 40)) then {
				[_data, _nearLocData] remoteExec ["lmn_fnc_ldAttackSite", 2];
				systemChat "[LD] Attacking";
			};
		};
	};
	sleep 10;
} forEach _locs;

sleep 30;
[] remoteExec ["lmn_fnc_ldTick", 2];
