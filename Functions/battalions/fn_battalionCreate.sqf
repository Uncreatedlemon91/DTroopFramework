// Creates a battalion to the Hashmap 
params ["_faction", "_location"];

// Create the battalion name 
_name = format ["%1/%2 Battalion HQ", selectRandom [1, 2, 3, 4, 5], round (random 500)];

// Create the composition of the force 
_infantryStrength = round (random 10);
_armorStrength = round (random 5);
_mechanizedStrength = round (random 4);
_reconStrength = round (random 5);
_composition = [_infantryStrength, _armorStrength, _mechanizedStrength, _reconStrength];

// Add other data points 
_mkrType = "";
switch (_faction) do {
	case "USA": {_mkrType = "b_hq"};
	case "ARVN": {_mkrType = "n_hq"};
	case "PAVN": {_mkrType = "o_hq"};
};
_data = [_faction, _name, _mkrType, _location, _composition];

// Setup a marker to the battalion 
_mkr = createMarkerLocal [_name, _location];
_mkr setMarkerTypeLocal _mkrType;
_mkr setMarkerSizeLocal [0.5, 0.5];
_mkr setMarkerText _name;

// Add marker to the Hashmap 
LemonBattalions set [_mkr, _data];

// Activate the battalion logic 
[_mkr] remoteExec ["lmn_fnc_battalionLogic", 2];
