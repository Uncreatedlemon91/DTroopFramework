// Spawns the group and keeps them moving toward their objective 
// Goes back to virtualized state once there are no players in the area 
params ["_trig"];

// Get Variables from the trigger 
_unitsToSpawn = _trig getVariable "TriggerUnits";
_spawnSide = _trig getVariable "TriggerSpawnSide";
_source = _trig getVariable "TriggerSource";
_destination = _trig getVariable "TriggerDestination";
_active = _trig getVariable "Activated";

// Use the variables to create the unit  
_troopGroup = createGroup _spawnSide;
_troopGroup deleteGroupWhenEmpty true;
_troopGroup setVariable ["lambs_danger_enableGroupReinforce", true, true];
_spawnPos = [position _trig, 0, 100, 5, 0, 3] call BIS_fnc_findSafePos;
_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];
{
	_class = getText (_x >> 'vehicle');
	_unit = _troopGroup createUnit [_class, _spawnPos, [], 10, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];	
	sleep 0.02;
} forEach _unitsToSpawn;

// Give troop a location to get to 
_wp1 = _troopGroup addWaypoint [_destination select 1, 20, 1];
_wp1 setWaypointBehaviour "AWARE";
_wp1 setWaypointType "MOVE";

// Once group created, create a loop to check the 'activated' state of the trigger 
while {_active} do {
	_ldr = leader _troopGroup;
	_ldrPos = getPos _ldr;
	_dest = _destination select 1;
	_dist = _ldrPos distance2D _dest;

	// during the check, check to see if they are close to their destination 
	if (_dist < 30) then {
		_travelling = false;
		_oldTroopLevel = _destination select 3;
		_newTroopLevel = _oldTroopLevel + _groupCount;
		_destination set [3, _newTroopLevel];

		// Sync database 
		[_destination] remoteExec ["lmn_fnc_saveLocation", 2];
		deleteVehicle _trig;
	}; 
	sleep 5;
};

// Cleanup
{
	deleteVehicle _x;
} forEach units _troopGroup;




// Despawn and restart the movement of the trigger 
