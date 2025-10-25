// This the logistics commander. 
// It will look for logistical needs and generate tasks for the players to complete as well as 
// dispatching it's own AI units. 

// Get the supply levels from the sites on the map 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_locs = "getSections" call _locDB;

// Loop the locations
{
	_data = ["read", [_x, "Data"]] call _locDB;
	_location = _data select 1;
	_trig = nearestObject [_location, "EmptyDetector"];
	systemchat format ["%1", _trig];

	// Get existing variables 
	_supplyLevel = _trig getVariable "SupplyLevel";
	_troopLevel = _trig getVariable "TroopCount";
	_maxTroopCount = _trig getVariable "MaxTroopCount";
	_faction = _trig getVariable "Faction";

	systemchat format ["%1", _troopLevel];
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
	_nearTrigs = nearestObjects [position _trig, ["EmptyDetector"], 1500, true];
	{
		// Grab near location's details 
		_trigTroopLevel = _x getVariable "TroopCount";
		_trigMaxTroopLevel = _x getVariable "MaxTroopCount";
		_trigFaction = _x getVariable "Faction";

		// Other Location is friendly 
		if (_faction == _trigFaction) then {
			// Should we send troops to the other location?
			if ((_troopLevel > _trigTroopLevel) AND (_trigTroopLevel < _trigMaxTroopLevel) AND (_troopLevel > 30)) exitwith {
				[_trig, _x] remoteExec ["lmn_fnc_ldSendTroops", 2];
				systemChat "[LD] Sending Troops";
			};
		};

		// Other location is hostile 
		if (_faction != _trigFaction) then {
			// Assess an attack 
			if (_troopLevel > _trigTroopLevel) AND (_troopLevel > 40) exitWith {
				[_trig, _x] remoteExec ["lmn_fnc_ldAttackSite", 2];
				systemChat "[LD] Attacking";
			};
		};
	} forEach _nearTrigs;
	
	// PHASE THREE - If location is in the Depot regions, spawn forces 
	if ((position _trig inArea "NORTH") AND (_faction == "PAVN") AND (_troopLevel < _maxTroopCount)) then {
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
	};
	sleep 5;
} forEach _locs;