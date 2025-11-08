// Spawns a battalion when a player is nearby 
params ["_battalionID"];

// Get the battalion database
_battalionDB = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;

// Read battalion info
_faction = ["read", [_battalionID, "Faction"]] call _battalionDB;
_position = ["read", [_battalionID, "Position"]] call _battalionDB;
_composition = ["read", [_battalionID, "Composition"]] call _battalionDB;
_veterancy = ["read", [_battalionID, "Veterancy"]] call _battalionDB;
_posture = ["read", [_battalionID, "Posture"]] call _battalionDB;

// Create Variables 
_side = "";

// Update Variables 
switch (_faction) do {
	case "USA": {
		_side = west;
	};
	case "PAVN": {
		_side = east;
	};
};

// Spawn the units 
{
	// Unpack Array
	_groupType = _x select 0;
	_groupCount = _x select 1;

	// Get units in the group type
	for "_i" from 1 to _groupCount do {
		_spawnPos = [_position, 0, 150, 10, 0, 0] call BIS_fnc_findSafePos;
		_units = "true" configClasses (_groupType);
		_group = createGroup _side;
		_group deleteGroupWhenEmpty true;
		{
			_unitClass = getText (_x >> 'vehicle');
			_unit = _group = createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
			_unit setSkill ["general", _veterancy];
			_unit setSkill ["aimingAccuracy", (_veterancy - 0.2)];
			_unit setSkill ["spotDistance", 1];
			_unit setSkill ["spotTime", 0.8];
			_unit setSkill ["courage", _veterancy];
			_unit setSkill ["reloadSpeed", _veterancy];
			_unit setSkill ["commanding", _veterancy];
			zeus addCuratorEditableObjects [[_unit], true];
			sleep 0.02;
		} forEach _units;

		// Give Group Variables and Event Handlers 
		(leader _group) setVariable ["lambs_danger_dangerRadio", true];
		_group setVariable ["lambs_danger_enableGroupReinforce", true, true];

		["lambs_danger_OnPanic", {
			params ["_unit", "_group"];
			_unit playAction "Surrender";
		}] call CBA_fnc_addEventHandler;
		
		// Give orders to the AI 
		switch (_posture) do {
			case "Staging": {
				[_group, _spawnPos, 50] call lambs_wp_fnc_taskCamp;
			};
			case "Defending": {
				[_group, _spawnPos, 150] call lambs_wp_fnc_taskGarrison;
			};
			case "Patrolling": {
				[_group, _spawnPos, 200] call BIS_fnc_taskPatrol;
			};
			case "Attacking": {
				[_group, 300] spawn lambs_wp_fnc_taskRush;
			};
		};

		// Loop delay
		sleep 1;
	};
} forEach _composition;