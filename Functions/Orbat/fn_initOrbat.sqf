// Initializes the orbat for mission play. If loading the ORBAT, no further action is required as it has already been established. 
// Get Databases 
_pavnDB = ["new", format ["ORBAT-PAVN %1 %2", missionName, worldName]] call oo_inidbi;
_vcDB = ["new", format ["ORBAT-VC %1 %2", missionName, worldName]] call oo_inidbi;
_usDB = ["new", format ["ORBAT-US %1 %2", missionName, worldName]] call oo_inidbi;
_ausDB = ["new", format ["ORBAT-AUS %1 %2", missionName, worldName]] call oo_inidbi;
_nzDB = ["new", format ["ORBAT-NZ %1 %2", missionName, worldName]] call oo_inidbi;

// Check if the databases are already populated. If so, exit script.
_dbExists = "exists" call _nzDB;
if (_dbExists) exitwith {};

// Build US Forces 
[_usdb, 3, 6, selectRandom ["Infantry", "Air Cavalry", "Armored", "Squadron"], selectRandom ["Aggressive", "Passive"], selectRandom [1,2,3,4,5]] call lmn_fnc_createOrbatEntry;
