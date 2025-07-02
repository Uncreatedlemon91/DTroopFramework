// Activates a Location 
params ["_trg"];
_loc = _trg getVariable "AttachedLocation";

// Get Variables 
_locSecurity = missionProfileNameSpace getVariable format ["%1-%2-Security", type _loc, position _loc], random 100;
_locPriority = missionProfileNameSpace getVariable format ["%1-%2-Priority", type _loc, position _loc], _priority;
_locTroops = missionProfileNameSpace getVariable format ["%1-%2-TroopStrength", type _loc, position _loc], random 3;
_locControl = missionProfileNameSpace getVariable format ["%1-%2-ControlledBy", type _loc, position _loc], selectRandom [0, 1, 3];

// Define what should happen at the site. 
// Use the above variables to decide how likely it is for items to spawn and instantize. 

// Spawn enemy forces defending the zone 

// Spawn Traps around the area outside of the location 

// Setup ambush zones outside the locations 

// Mine the roads 

// Call in Air support if in PAVN Controlled Zone - This needs to be based on the enemy RTO's. 

// Setup emplacement weaponary / mortar sites in the area 

// Setup patrols outside the area

// Are reinforcements available? 