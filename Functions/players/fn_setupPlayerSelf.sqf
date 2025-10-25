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

// Setup event handler for Player Deaths 
_player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    _curDate = systemtime;
    _ddMMyyyy = format [
        "%2/%1/%0", 
        _curDate select 0,
        (if (_curDate select 1 < 10) then { "0" } else { "" }) + str (_curDate select 1),
        (if (_curDate select 2 < 10) then { "0" } else { "" }) + str (_curDate select 2)
    ];
    _hhmm = format ["%1:%2", _curDate select 3, _curDate select 4];

    [name _unit, _ddMMyyyy, _hhmm] remoteExec ["lmn_fnc_recordDeath", 2];
}];

