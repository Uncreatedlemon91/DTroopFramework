// Function to spawn in civilians to the area and provide them with variables needed for 
// COIN operations. 
params ["_trig"];

// Get Variables 
_civCount = _trig getVariable "CivCount";

// Spawn the civilian 
for "_i" from 1 to _civCount do {
	// Find a position to spawn the Civilian 
	_spawnPos = [position _trig, 10, 100, 5, 0, 10, 0] call BIS_fnc_findSafePos;
	_group = createGroup Civilian;
	_group deleteGroupWhenEmpty true;

	// Select model for civilian 
	_class = [];
	_unit = _group createUnit [_class, _spawnPos, [], 0, "FORM"];

	// Give the Civilian something to do 
	[_group, _spawnPos, 600] call BIS_fnc_taskPatrol;

	// Add the civilian to the trigger's spawned units array
	_currentUnits = _trig getVariable "ActiveTroops";
	_currentUnits pushback _unit;
	_trig setVariable ["ActiveTroops", _currentUnits, true];

	// Sleep delay for performance 
	sleep 0.02;
};