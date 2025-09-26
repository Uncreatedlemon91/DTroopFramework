// Attacks a nearby location 
params ["_attacker", "_forces", "_defender"];

// Setup the Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_defenderSide = ["read", [_defender, "Side"]] call _locDB;
_attackerSide = ["read", [_attacker, "Side"]] call _locDB;

// Calculate how many forces are going to attack 
_attackForce = round (random _forces);
_attackerSpawn = ["read", [_attacker, "Pos"]] call _locDB;
_defenderSpawn = ["read", [_defender, "Pos"]] call _locDB;
