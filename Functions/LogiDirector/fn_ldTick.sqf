// This the logistics commander. 
// It will look for logistical needs and generate tasks for the players to complete as well as 
// dispatching it's own AI units. 

systemchat "[LD] - Starting Tick";

// Get the supply levels from the sites on the map 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locDB;

// Loop the locations
{
	_data = ["read", [_x, "Data"]] call _locDB;
	_locationPos = _data select 1;
	// systemChat format ["_trig: %1", _trig];
	// Get existing variables 
	_supplyLevel = _data select 5;
	_troopLevel = _data select 3;
	_maxTroopCount = _data select 4;
	_faction = _data select 2;

	// PHASE ONE - Self Preservation 
	// Check supply
	if (_supplyLevel < 50) then {
		_needsSupply pushback _x;
	};
	// Check troops
	if (_troopLevel < 30) then {
		_needTroops pushback _x;
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
		if ((_troopLevel > _trigTroopLevel) AND (_trigTroopLevel < _trigMaxTroopLevel) AND (_troopLevel > 30)) then {
			[_data, _nearLocData] remoteExec ["lmn_fnc_ldSendTroops", 2];
			systemChat "[LD] Sending Troops";
		};
	};

	// Other location is hostile 
	if (_faction != _trigFaction) then {
		// Assess an attack 
		if (_troopLevel > _trigTroopLevel) AND (_troopLevel > 40) then {
			[_data, _nearLocData] remoteExec ["lmn_fnc_ldAttackSite", 2];
			systemChat "[LD] Attacking";
		};
	};
	
	// PHASE THREE - If location is in the Depot regions, spawn forces 
	/*if ((position _trig inArea "NORTH") AND (_faction == "PAVN") AND (_troopLevel < _maxTroopCount)) then {
		_newLevel = _troopLevel + round(random 30);
		_trig setVariable ["TroopCount", _newLevel, true];
	};
	if ((position _trig inArea "SOUTH") AND (_faction == "ARVN") AND (_troopLevel < _maxTroopCount)) then {
		_newLevel = _troopLevel + round(random 30);
		_trig setVariable ["TroopCount", _newLevel, true];
	};
	if ((position _trig inArea "US") AND (_faction == "US") AND (_troopLevel < _maxTroopCount)) then {
		_newLevel = _troopLevel + round(random 30);
		_trig setVariable ["TroopCount", _newLevel, true];
	};*/
	systemChat format ["Completed %", _data select 11];
	sleep 10;
} forEach _locs;

sleep 30;
[] remoteExec ["lmn_fnc_ldTick", 2];
