// Script fired when user attempts to cut tree down.
params ["_player"];

// Define variables
_cutters = ["vn_m_axe_01", "vn_m_typeivaxe_01"];
_weapon = currentWeapon _player;

// Check if cutters are legit 
if (_weapon in _cutters) then {
	_tree = (nearestTerrainObjects [_player, ["TREE", "SMALL TREE", "FOREST", "BUSH"], 5, true, false]) select 0;
	if (isnil "_tree") exitWith {systemChat "No trees nearby!"};
	systemChat "Cutting Tree...";
	[_player, (selectRandom ["REPAIR_VEH_STAND", "REPAIR_VEH_KNEEL"]), "ASIS"] call BIS_fnc_ambientAnim;
	sleep 10;
	_player call BIS_fnc_ambientAnim__terminate;

	// Save the Tree 
	[_tree] remoteExec ["lmn_fnc_saveTree", 2];
} else {
	systemChat "You must have an Axe equipped to do this!";
};