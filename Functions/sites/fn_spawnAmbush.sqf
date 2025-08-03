// Spawns an ambush for the player. 
params ["_trg"];

// Define ambushers and ambush size 
_ambushSize = round (random 10);
_ambushForce = [];
for "_i" from 1 to _ambushSize do {
	_class = selectRandom (lmn_PAVN select 0);
	_ambushForce pushback _class;
};

// Make the unit  
_grp = createGroup East;
{
	_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["TREE", "BUSH"], 50, false, false]));
	_unit = _grp createUnit [_class, _pos];
	_unit setUnitPos "DOWN";

	// Check for nearby players 
	[_unit, _trg] remoteExec ["lmn_fnc_despawnAI", 2];
} forEach _ambushForce;

// Give the unit orders to defend the point  
[_grp, position _trg] call BIS_fnc_taskDefend;
