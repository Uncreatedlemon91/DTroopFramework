// Spawns the AI forces in the area when the grid is activated
params ["_trg", "_type"];

// Setup Variables 
_faction = _trg getVariable "gridSide";
_grp = "";
_comp = _type select 0;
_side = east;
switch (_faction) do {
	case "North": {_side = east};
	case "USA": {_side = west};
	case "ARVN": {_side = independent};
};
_unitType = _type select 2;

// Define type of unit being deployed 
switch (_unitType) do {
	case "Infantry": {
		// Create the group
		_grp = createGroup _side;
		_grp deleteGroupWhenEmpty true;
		// systemChat format ["Spawning %1", _comp];

		// Spawn the units in the area
		_spawnPos = [position _trg, 0, 200, 1, 0, 20, 0] call BIS_fnc_findSafePos;
		{
			_unit = _grp createUnit [_x, position _trg, [], 10, "FORM"];
			zeus addCuratorEditableObjects [[_unit], true];
			sleep 0.03;
		} forEach _comp;

		// Patrol the area 
		[_grp, _spawnPos, 400] call lambs_wp_fnc_taskPatrol;
	};
	case "Turret": {
		_spawnPos = [position _trg, 0, 200, 1, 0, 40, 0] call BIS_fnc_findSafePos;
		_turret = [_spawnPos, (random 360), _comp select 0, _side] call BIS_fnc_spawnVehicle;
		_unit = _turret select 0;
		_grp = _turret select 2;
		zeus addCuratorEditableObjects [[_unit], true];
	};
	case "Armored": {
		_spawnPos = [position _trg, 0, 200, 1, 0, 40, 0] call BIS_fnc_findSafePos;
		_turret = [_spawnPos, (random 360), _comp select 0, _side] call BIS_fnc_spawnVehicle;
		_unit = _turret select 0;
		_grp = _turret select 2;
		zeus addCuratorEditableObjects [[_unit], true];
		[_grp, _spawnPos, 200] call lambs_wp_fnc_taskPatrol;
	}
};

// Add the group to a list of the active groups in this grid
_activeGroups = _trg getVariable ["gridActiveGroups", []];
_activeGroups pushBack _grp;
_trg setVariable ["gridActiveGroups", _activeGroups, true];