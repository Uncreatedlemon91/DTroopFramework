// Checks the nearby locations to get a strategic overview of the area
params ["_locs", "_currentLoc"];

// Start the Database 
_db = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Define rules for allegiance 
_west = ["USA", "ROK", "AUS", "NZ"];
_east = ["North"];
_currentSide = ["read", [_currentLoc, "Allegiance"]] call _db;
_side = "east";
if (_currentSide in _west) then {
	_side = "west";
};

// Define actions that may occur between the two locations 
_attack = 0;
_reinforce = 0;
_build = 0;
_transfer = 0;
_probe = 0;

// Array to hold potential targets 
_targets = [];
_friendlies = [];
_orders = [];

// Grab information about the current location
_currentgarrisonSize = ["read", [_currentLoc, "GarrisonSize"]] call _db;
_currentPriority = ["read", [_currentLoc, "Priority"]] call _db;

// Check nearby locations 
{
	// Save _x Variable
	_location = _x;
	// check the other location side
	_otherLocSide = ["read", [_x, "Allegiance"]] call _gridDB;
	systemChat format ["Assessing location %1", (["read", [_x, "Name"]] call _gridDB)];
	systemChat format ["Location side: %1", _otherLocSide];
	_garrisonSize = ["read", [_x, "GarrisonSize"]] call _gridDB;
	systemChat format ["Garrison Size: %1", _garrisonSize];
	if (_otherLocSide in _west) then {
		_otherLocSide = "west";
	} else {
		_otherLocSide = "east";
	};
	systemChat format ["Location side: %1", _otherLocSide];

	// Compare sides
	if (_side == _otherLocSide) then {
		systemchat "This is a friendly location";
		// This is another friendly location. 
		_transfer = _transfer + 1;
		_build = _build + 1;

		_friendlies pushback _x;
		systemchat format ["Friendly location added: %1", (["read", [_x, "Name"]] call _gridDB)];
		
		// Compare priority level
		_priority = ["read", [_x, "Priority"]] call _gridDB;
		if (_priority > _currentPriority) then {
			// This location is more important. 
			systemChat "This location is more important!";
			_transfer = _transfer + 1;
		};

		// Compare Garrison Size. 
		if (_garrisonSize > _currentgarrisonSize) then { 
			_reinforce = _reinforce + 1;
		} else {
			_transfer = _transfer + 1;
		};
		systemChat format ["Garrison comparison: This %1 vs Current %2", _garrisonSize, _currentgarrisonSize];

		_orders = selectRandomWeighted [
			"transfer", _transfer,
			"reinforce", _reinforce,
			"build", _build,
			"hold", 6
		];
		systemChat format ["Orders selected: %1", _orders];
	};
	
	if !(_side == _otherLocSide) then {
		systemChat "This is a hostile location";
		// This is a hostile location.
		if (_garrisonSize > _currentgarrisonSize) then {
			// Enemy has more power
			systemchat "Enemy has superior forces!";
			_reinforce = _reinforce + 1;
			_build = _build + 1;
			_probe = _probe + 1;
		} else {
			// Enemy has less power
			systemChat "Enemy forces are weaker!";
			_attack = _attack + 2;
			_targets pushback _location;
		};

		_orders = selectRandomWeighted [
			"attack", _attack,
			"reinforce", _reinforce,
			"build", _build,
			"probe", _probe,
			"hold", 6
		];
		systemChat format ["Orders selected: %1", _orders];
	};

	sleep 10;
} forEach _locs;

// Decide what to do based on importance, player presence, current forces, etc.

_target = "";
if ((_orders == "attack") OR (_orders == "probe")) then {
	_target = selectRandom _targets;
} else {
	_target = selectRandom _friendlies;
};

// Return
systemChat format ["Final Decision: %1 %2", _target, _orders];	
[_target, _orders];