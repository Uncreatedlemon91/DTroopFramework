// Setup the player 
[player] remoteExec ["lmn_fnc_setupPlayer", 2];

// Send the player to be loaded 
[player] remoteExec ["lmn_fnc_loadPlayer", 2];

while {true} do {
	sleep 20;
	[player] remoteExec ["lmn_fnc_savePlayer", 2];
};