// Setup the player 
// [player] remoteExec ["lmn_fnc_setupPlayer", 2];
[] call lmn_fnc_addActions;


// Send the player to be loaded 
[player] remoteExec ["lmn_fnc_loadPlayer", 2];

// Wait a while before the loop starts 
sleep 20;

// Loop to save player data
while {true} do {
	sleep 20;
	[player] remoteExec ["lmn_fnc_savePlayer", 2];
};