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
	_class = selectRandom [
		"vn_c_men_13",
		"vn_c_men_23",
		"vn_c_men_22",
		"vn_c_men_23",
		"vn_c_men_24",
		"vn_c_men_25",
		"vn_c_men_26",
		"vn_c_men_27",
		"vn_c_men_28",
		"vn_c_men_29",
		"vn_c_men_30",
		"vn_c_men_31",
		"vn_c_men_14",
		"vn_c_men_32",
		"vn_c_men_15",
		"vn_c_men_16",
		"vn_c_men_18",
		"vn_c_men_19",
		"vn_c_men_20",
		"vn_c_men_21",
		"vn_c_men_05",
		"vn_c_men_06",
		"vn_c_men_07",
		"vn_c_men_08",
		"vn_c_men_08",
		"vn_c_men_01",
		"vn_c_men_03",
		"vn_c_men_04",
		"vn_c_men_09",
		"vn_c_men_10",
		"vn_c_men_11",
		"vn_c_men_12"
	];
	_unit = _group createUnit [_class, _spawnPos, [], 0, "FORM"];

	// Give the Civilian something to do 
	[_group, _spawnPos, 600] call BIS_fnc_taskPatrol;

	// Add the civilian to the trigger's spawned units array
	_currentUnits = _trig getVariable ["ActiveTroops",[]];
	_currentUnits pushback _unit;
	_trig setVariable ["ActiveTroops", _currentUnits, true];

	// Sleep delay for performance 
	sleep 0.02;
};