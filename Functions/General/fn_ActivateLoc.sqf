// Activates a Location 
params ["_trg"];
if !(triggerActivated _trg) then {
	_loc = _trg getVariable "AttachedLocation";

	// Debug 
	systemChat format ["%1-%2 Activated!", text _loc, type _loc];

	// Get Variables 
	_locData = missionProfileNameSpace getVariable format ["%1-%2-Data", type _loc, position _loc];
	_locSecurity = _locData select 0;

	// Define what should happen at the site. 
	// Use the above variables to decide how likely it is for items to spawn and instantize. 
	_functions = [
		"lmn_fnc_spawnEnemies",
		"lmn_fnc_spawnTraps",
		"lmn_fnc_spawnAmbushes",
		"lmn_fnc_spawnMines",
		"lmn_fnc_spawnEmplacements",
		"lmn_fnc_spawnPatrols"
	];

	// Setup functions for the AO 
	{
		_random = random 100;
		if (_random > _locSecurity) then {
			[_loc] remoteExec [_x, 2];
		};
	} forEach _functions;
} else {
	// Debugging tool 
	// systemChat "Trigger is already activated";
};