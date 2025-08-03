// Walks around the town, going to random houses and locations 
params ["_unit", "_loc", "_grp"];

// Set unit paramaters 
(_grp) setSpeedMode "LIMITED";

// Find a nearby Tree 
_tree = nearestTerrainObjects [position _unit, ["TREE"], 100, false, true];

// Set the waypoint to move to the tree 
_wp1 = _grp addWaypoint [position _tree, 0, 1];
_wp1 setWaypointCompletionRadius 2;

// Wait until the civ is near the tree 
waitUntil {(sleep 3; _unit distance _tree) < 2};

// Set animation
_faceDir = _unit getRelDir _tree;
_unit setDir _faceDir;
[_unit, "REPAIR_VEH_STAND", "ASIS"] call BIS_fnc_ambientAnim;

// Set the next task for the civilian
_action = selectRandom lmn_civActions;
[_unit, _loc, _grp] remoteExec [_action, 2];