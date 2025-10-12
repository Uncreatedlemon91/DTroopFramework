// Setup the player 
[] call lmn_fnc_addActions;

// Send the player to be loaded 
[player, clientOwner] remoteExec ["lmn_fnc_getPlayerData", 2];
[player] call lmn_fnc_setupPlayerSelf;

// Wait a while before the loop starts 
sleep 5;

// Loop to save player data
while {true} do {
	sleep 20;
	[player] remoteExec ["lmn_fnc_savePlayer", 2];
};