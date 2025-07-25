// Activated when players enter the trigger zone 
params ["_trg"];

// Get the forces present 
_forces = _trg getVariable "Forces";
_infantry = _forces select 0;
_aa = _forces select 1;
_turrets = _forces select 2;
_armor = _forces select 3;

// Setup infantry 
for "_i" from 1 to _infantry do {
	_spawnPos = [[_trg], []] call BIS_fnc_randomPos;
	
}