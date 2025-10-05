// Prepares the trigger and information for an ambush 
params ["_loc", "_faction", "_locPos"];
_pos = position (selectRandom (nearestTerrainObjects [_locPos, ["ROAD", "TRAIL", "MAIN ROAD", "BUSH"], 800, false, false]));
if (isnil "_pos") then {
	_pos = [_locPos, 0, 1000, 5, 0, 10, 0] call BIS_fnc_findSafePos;
};
_alpha = 0;

// Setup a Marker
_mkr = createMarker [format ["%1-%2", _loc, _pos], _pos];
_mkr setMarkerType "hd_dot";
_mkr setMarkerColor "COLORRED";
_mkr setMarkerAlpha _alpha;

// Determine the ambush details 
_side = west;
_factionToSpawn = "";
_triggerSide = east;
switch (_faction) do {
	case "North": {_factionToSpawn = lmn_pavn; _side = east; _triggerSide = west};
	case "USA": {_factionToSpawn = lmn_US};
	case "ROK": {_factionToSpawn = lmn_ROK};
	case "AUS": {_factionToSpawn = lmn_AUS};
	case "NZ": {_factionToSpawn = lmn_NZ};
};

// Make the unit
_infantrySize = random [8, 12, 15];
_reconSize = random [2, 4, 6];
_toSpawn = [];

for "_i" from 1 to _infantrySize do {
	_infantry = selectRandom (_factionToSpawn select 0);
	_toSpawn pushback _infantry;
};
for "_i" from 1 to _reconSize do {
	_recon = selectRandom (_factionToSpawn select 1);
	_toSpawn pushback _recon;
};

// Setup Trigger
_prep = createTrigger["EmptyDetector", _pos, true];
_prep setTriggerActivation [_triggerSide, "PRESENT", true];
_prep setTriggerArea [250, 250, 0, false, 100];
_prep setTriggerInterval 5;
_prep setTriggerStatements [
	"this",
	"[thisTrigger] remoteExec ['lmn_fnc_spawnAmbush', 2]",
	"thisTrigger setVariable ['Activated', false]"
];

_prep setVariable ["attachedLocation", _loc];
_prep setVariable ["faction", _faction];
_prep setVariable ["Activated", false];
_prep setVariable ["ToSpawn", _toSpawn, true];
_prep setVariable ["FactionSide", _side];
