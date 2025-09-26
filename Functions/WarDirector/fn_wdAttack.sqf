// Attacks a nearby location 
params ["_attacker", "_forces", "_defender"];

// Setup the Database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_defenderSide = ["read", [_defender, "Side"]] call _locDB;
_attackerSide = ["read", [_attacker, "Side"]] call _locDB;

// Calculate how many forces are going to attack 
_attackForce = round (random _forces);

// Remove the attack force from the original side force 
_newAttackGarrison = _forces - _attackForce;
["write", [_attacker, "GarrisonForces", _forces]] call _locDB;

// Place the attacking forces in the AO of the defender 
_attackerSpawnPos = ["read", [_defender, "Pos"]] call _locDB;
for "_i" from 1 to _attackForce do {
	[_defender, _attackerSide, _attackerSpawnPos] remoteExec ["lmn_fnc_prepAmbush", 2];
	sleep 0.01;
};
