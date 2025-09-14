// Spawns the AI forces in the area when the grid is activated
params ["_trg", "_type"];

// Create the group
_grp = createGroup (_trg getVariable "gridSide");
_comp = _type select 0;
_spawnPos = [position _trg, 0, 200, 4, 0, 20, 0] call BIS_fnc_findSafePos;
{
	_unit = _grp createUnit [_x, position _trg, [], 10, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];
	sleep 0.03;
} forEach _comp;

// Patrol the area 
[_grp, _spawnPos, 400] call lambs_wp_fnc_taskPatrol;