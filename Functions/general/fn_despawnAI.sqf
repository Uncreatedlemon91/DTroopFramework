// Checks for nearby players then removes the AI and resets the trigger  
params ["_unit", "_trg", "_type"];

_grp = group _unit;
_dist = 200;
_dbType = "";
_statics = ["AAsites"];
_destroyed = false;
_active = triggerActivated _trg;

switch (_type) do {
	case "Civilian": {_dist = 200; _dbType = "Population"};
	case "Ambush": {_dist = 250; _dbType = "AmbushCount"};
	case "AA": {_dist = 800; _dbType = "AAsites"};
	case "Garrison": {_dist = 500; _dbType = "GarrisonSize"};
};

// Wait until players are no longer nearby 
while {_active} do {
	_trg setPos _unit;

	// Routinely check if AI Group is smaller than 2, in which case, it is 'destroyed'.
	if ((_groupCount <= 2) AND !(side _unit == civilian) AND !(_dbType in _statics) AND (_destroyed == false)) then {
		_section = _trg getVariable "attachedLocation";
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_currentCount = ["read", [_section, _dbType]] call _locDB;
		_newCount = _currentCount - 1;
		_destroyed = true;
		["write", [_section, _dbType, _newCount]] call _locDB;
		systemChat format ["%1 has been removed!", _dbType];
	};

	// Delete units if no players nearby 
	if (_nearPlayers == 0) exitwith {
		_trg setVariable ["Active", false];
		{
			deleteVehicle (vehicle _x);
			deleteVehicle _x;
		} forEach units _grp;
	};
};