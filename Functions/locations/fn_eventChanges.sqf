// Adapts the locations once every real time day. 
_savedTime = [];
while {true} do {
	_time = [(systemTime select 2), (systemTime select 1), (systemTime select 0)];
	if (_time != _savedTime) then {
		// Get the Database Entry 
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_sections = "getSections" call _locDB;
		_allies = ["USA", "ROK", "AUS", "NZ"];

		{
			_currentEvent = ["read", [_x, "dayEvent"]] call _locDB;
			_nearLocs = ["read", [_x, "NearLocations"]] call _locDB;
			_locFaction = ["read", [_x, "Allegiance"]] call _locDB;
			_alliedFactions = [];
			_northFactions = [];
			_locGarrisonSize = ["read", [_x, "GarrisonSize"]] call _locDB;
			{
				// Current result is saved in variable _x
				_faction = ["read", [_x, "Allegiance"]] call _locDB;
				if (_faction == "North") then {
					_northFactions pushback _x;
				};
				if (_faction in _allies) then {
					_alliedFactions pushback _x;
				};
			} forEach _nearLocs;

			// Decision for an action 
			if (_locFaction == "North") then {
				_targetLocations = _alliedFactions;
				_alliedLocations = _northFactions;
			} else {
				_targetLocations = _northFactions;
				_alliedLocations = _alliedFactions;
			};

			_potentialTarget = [];
			{
				// Current result is saved in variable _x
				_garrisonSize = ["read", [_x, "GarrisonSize"]] call _locDB;
				if (_locGarrisonSize > _garrisonSize) then {
					_potentialTarget pushback _x;
				};
			} forEach _targetLocations;

			_supportTarget = [];
			{
				// Current result is saved in variable _x
				_garrisonSize = ["read", [_x, "GarrisonSize"]] call _locDB;
				if (_locGarrisonSize > _garrisonSize) then {
					_potentialTarget pushback _x;
				};
			} forEach _alliedLocations;

			_missionDecision = [];
			if ((count _supportTarget) > (count _potentialTarget)) then {
				_missionDecision = selectRandomWeighted ["lmn_fnc_eventReinforce", 0.5, "lmn_fnc_eventAttack", 0.3, "lmn_fnc_eventBuild", 0.2];
			} else {
				_missionDecision = selectRandomWeighted ["lmn_fnc_eventReinforce", 0.5, "lmn_fnc_eventAttack", 0.3, "lmn_fnc_eventBuild", 0.2];
			};

			["write", [_x, "dayEvent", _missionDecision]] call _locDB;
			sleep 0.5;	
		} forEach _sections;
		
		_savedTime = [(systemTime select 2), (systemTime select 1), (systemTime select 0)];
	};
	sleep 1800;
};