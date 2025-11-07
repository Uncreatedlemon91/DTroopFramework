// Gets the players applies the selected loadout to the player. 
params ["_kit", "_player", "_box"];

/*// Check if the player has the role 
_hasRole = [_player, _kit] call lmn_fnc_getPlayerWhitelistedRoles;
if !(_hasRole) exitWith {["You do not have this role unlocked!"] remoteExec ["systemChat", netId _player]};
*/
// Get the loadout from the loadout character 
_loadout = getUnitLoadout _kit;

// Apply the loadout to the player 
_player setUnitLoadout _loadout;

// Add the relevant variables 
_player setVariable ["CurrentKit", _kit];

_medicalRoles = [];
_engineerRoles = [Mechanic];

if (_kit in _medicalRoles) then {
	_player setVariable ["ace_medical_medicclass", 1, true];
};

if (_kit in _engineerRoles) then {
	_player setVariable ["ace_isEngineer", 1, true];
};

// Open the arsenal for player customization 
[_player, [
	// Helmets
	"vn_b_helmet_m1_14_01",
	"vn_b_helmet_m1_15_01",
	"vn_b_helmet_m1_16_01",
	"vn_b_helmet_m1_18_01",
	"vn_b_helmet_m1_19_01",
	"vn_b_helmet_m1_02_01",
	"vn_b_helmet_m1_20_01",
	"vn_b_helmet_m1_03_01",
	"vn_b_helmet_m1_05_01",
	"vn_b_helmet_m1_06_01",
	"vn_b_helmet_m1_07_01",
	"vn_b_uniform_macv_01_07",
	"vn_b_uniform_macv_04_07",
	"vn_b_uniform_macv_05_07",
	"vn_b_uniform_macv_06_07"

], false] call ace_arsenal_fnc_initBox;
[_player, _player, false] call ace_arsenal_fnc_openBox;

// Save current loadout to the player's database profile 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;
_uid = getPlayerUID _player;
["write", [_uid, "Player Kit", str _kit]] call _db;

// Delete the box 
if (typeOf _box == "vn_b_ammobox_supply_04") then {
	[_box, "itemdb"] remoteExec ["lmn_fnc_deleteFromDatabase", 2];
};