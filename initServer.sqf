// Loads the mission file on server side 
// Admin / Debug stuff 
debugMode = false;
resetBodyMarkers = false;
resetPlayerLives = false;
resetBulletCounts = false;
resetPlayerData = false;

// Disable Dogtags on factions 
"CIV_F" call ace_dogtags_fnc_disableFactionDogtags;
"O_VC" call ace_dogtags_fnc_disableFactionDogtags;
"O_PAVN" call ace_dogtags_fnc_disableFactionDogtags;

// Load saved data 
[] call lmn_fnc_loadBodyMarkers;

// Start simulation of PAVN 
_pavnCount = 6;
for "_i" from 1 to _PavnCount do {
    // [] call lmn_fnc_PAVN;
};

[] call lmn_fnc_locations;