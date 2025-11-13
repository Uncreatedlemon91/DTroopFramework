// Creates a virtualized convoy from Logistics HUB to a low supply location
params ["_dest", "_faction", "_hub"];

// Get the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// create Variables 
_supplyVeh = "";
_side = "";
_supplyQty = 0;
_dropOff = ["read", [_dest, "Position"]] call _locDB;
_startPos = ["read", [_hub, "Position"]] call _locDB;

// Update variables 
switch (_faction) do {
	case "USA": {
		_side = west;
		_supplyQty = 50;
		_supplyVeh = "vn_b_air_ch47_04_01"; // Chinook
	};
};

// Create the vehicle 
_spawnPos = [_startPos, 0, 100, 20, 0, 20, 0] call BIS_fnc_findSafePos;
_grp = createGroup _side;
_grp deleteGroupWhenEmpty true;
_veh = [_spawnPos, 0, _supplyVeh, _grp] call BIS_fnc_spawnVehicle;
_heli = _veh select 0;

// Attach a marker 
[_heli, "b_air", format ["Flight To %1", ["read", [_dropOff, "Site Name"]] call _locDB]] spawn lmn_fnc_attachMarker; 

// Update Database for HUB 
_oldSupply = ["read", [_hub, "Supply"]] call _locDB;
_newSupply = _oldSupply - _supplyQty;
["write", [_hub, "Supply", _newSupply]] call _locDB;

// Send the unit  
[_grp, _dropOff, _heli] spawn BIS_fnc_wpLand;
sleep 10;
waitUntil {
	sleep 1;
	_pos = getPosATL _heli; 
	(_pos select 2) < 5;
};

// Update Database for Destination 
_oldSupply = ["read", [_dest, "Supply"]] call _locDB;
_newSupply = _oldSupply + _supplyQty;
["write", [_dest, "Supply", _newSupply]] call _locDB;

// Send the convoy back 
_exfilPos = [_startPos, 0, 100, 20, 0, 20, 0] call BIS_fnc_findSafePos;
[_grp, _exfilPos, _heli] spawn BIS_fnc_wpLand;
waitUntil {
	sleep 5;
	_pos = getPosATL _heli; 
	(_pos select 2) < 10;
};

// Delete the convoy
{
	// Current result is saved in variable _x
	deleteVehicle _x;
} forEach crew _heli;
deleteVehicle _heli;
deleteGroup _grp;

