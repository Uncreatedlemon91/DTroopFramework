// A tick / Script loop that adds the decision making logic to the war director and orders AI to move 
// around the map, Move to objectives, defend areas, etc.

// Pull database 
_gridDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_objs = "getSections" call _gridDB;

// Main loop
{
	// Check location data 
	_objData = ["read", [_x, "Data"]] call _gridDB;

	// Debug notice 
	systemChat format ["WD Tick: Checking location %1", _objData select 0];

	// Define action variables 
	_move = 0;
	_reinforce = 0;
	_resupply = 0;

	// Should we reinforce?
	if ((_objData select 3) < (_objData select 4)) then {
		_reinforce = _reinforce + 1;
	};

	// Should we Move?
	if ((_objData select 3) > (_objData select 4) / 2) then {
		_move = _move + 1;
	};

	// Should we get resupplied? 
	if ((_objData select 5) < 50) then {
		_resupply = _resupply + 1;
	};

	// Decide action based on random weighted values 
	_action = selectRandomWeighted [
		"Reinforce", _reinforce,
		"Move", _move,
		"Resupply", _resupply
	];

	// Execute action
	switch (_action) do {
		case "Reinforce": {[_x] remoteExec ["lmn_fnc_wdReinforce", 2]};
		case "Move": {[_x] remoteExec ["lmn_fnc_wdMove", 2]};
		case "Resupply": {[_x] remoteExec ["lmn_fnc_wdResupply", 2]};
		default { };
	};

	// Save the database

	// debug 
	
} forEach _objs;
