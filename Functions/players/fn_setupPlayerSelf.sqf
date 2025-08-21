// Sets up the player with event handlers and such 
params ["_player"];

// Setup tree removal 
_treeRemovalAction = [
    "removeTree", 
    "Clear Tree", 
    "", 
    {
		params ["_target", "_player", "_params"];
		[_player] remoteExec ["lmn_fnc_actionTreeRemoval", _player];
	}, 
    {true}
] call ace_interact_menu_fnc_createAction;

[_player, 1, ["ACE_SelfActions"], _treeRemovalAction] call ace_interact_menu_fnc_addActionToObject;