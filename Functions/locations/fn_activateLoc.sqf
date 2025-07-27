// Activated when players enter the trigger zone 
params ["_trg"];

// Get Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get the forces present 
