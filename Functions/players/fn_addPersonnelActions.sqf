// Add actions to the command vehicle 
params ["_veh"];

// Create and add ACE Interaction 
_PlayerManagement = [
    "playerManagement", 
    "Player Management", 
    "", 
    {		
		params ["_target", "_player", "_params"];
		_nearPlayers = [_target] call lmn_fnc_getNearPlayers;
		{
			// Current result is saved in variable _x
			_name = name _x;
			_playerActions = [
				_name,
				_name,
				"",
				{},
				{true}
			] call ace_interact_menu_fnc_createAction;

			// Add nearby player to the menu
			[_target, 0, ["ACE_MainActions", "playerManagement"], _playerActions] call ace_interact_menu_fnc_addActionToObject;
		} forEach _nearPlayers;
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

// Add the action category to the command vehicle 
[_veh, 0, ["ACE_MainActions"], _PlayerManagement] call ace_interact_menu_fnc_addActionToObject;