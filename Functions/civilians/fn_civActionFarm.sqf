// Walks around the town, going to random houses and locations 
params ["_unit", "_loc", "_grp"];

// Set unit paramaters 
(_grp) setSpeedMode "LIMITED";

// Find a nearby Tree 
_tree = selectRandom (nearestTerrainObjects [position _unit, ["TREE"], 100, false, true]);

// Set the waypoint to move to the tree 
_dest = getpos _tree;
_dest = [(_dest select 0), (_dest select 1), 0];
_wp1 = _grp addWaypoint [_dest, 0, 1];

// Wait until the civ is near the tree 
_dist = _unit distance _tree;
while {_dist > 10} do {
	_dist = _unit distance _tree;
	systemChat format ["Distance: %1", _dist];
	sleep 4;
};

systemChat "Starting animation";

// Set animation
_faceDir = _unit getRelDir _tree;
_unit setDir _faceDir;
[_unit, "REPAIR_VEH_STAND", "ASIS"] call BIS_fnc_ambientAnim;

// Set the next task for the civilian
_action = selectRandom lmn_civActions;
[_unit, _loc, _grp] remoteExec [_action, 2];