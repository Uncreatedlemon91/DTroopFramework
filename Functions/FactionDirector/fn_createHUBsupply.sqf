// Moves offmap supplies to the HUB location
params ["_location", "_faction"];

// Set random delay to stagger missions 
// sleep (random 120);

// Get Database
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get location details
_siteName = ["read", [_location, "Site Name"]] call _locDB;
_sitePos = ["read", [_location, "Position"]] call _locDB;

// Create Variables 
_supplySource = "";
_supplyVehicle = "";
_side = "";

// Update Variables 
if (_faction == "USA") then {
	_supplySource = selectRandom [
		"supply_japan",
		"supply_navy"
	];
	_supplyVehicle = "vnx_b_air_ac119_03_01";
	_side = west;

		
	// Build supply convoy 
	_vehicle = [getMarkerPos _supplySource, 0, _supplyVehicle, _side] call BIS_fnc_spawnVehicle;
	_plane = _vehicle select 0;
	[_plane, "b_plane", "Resupply Flight"] spawn lmn_fnc_attachMarker;

	// Add event handlers 
	_plane addEventHandler ["LandedStopped", {
		params ["_plane", "_airportID", "_airportObject"];
		_plane setVariable ["lmnLanded", true, true];
	}];

	// Send convoy to location
	[_vehicle select 2, _sitePos, _plane] spawn BIS_fnc_wpLand;
	_plane flyInHeight 1000;

	// Notify players
	systemchat format ["[US Director] Supply convoy dispatched from %1 to Logistics HUB at %2.", _supplySource, _siteName];

	// Upon arrival, increase location supply
	waitUntil {
		sleep 1;
		_plane getVariable ["lmnLanded", false];
	};

	// Increase supply level
	_currentSupply = ["read", [_location, "Supply"]] call _locDB;
	_newSupply = _currentSupply + 100;
	["write", [_location, "Supply", _newSupply]] call _locDB;
	systemchat format ["[US Director] Supply convoy has arrived at %1. Supply level increased to %2.", _siteName, _newSupply];

	waitUntil {
		sleep 1;
		_distance = (getMarkerPos _supplySource) distance (getPos _plane);
		_distance < 200;
	};

	// Delete vehicle / Cleanup
	{
		// Current result is saved in variable _x
		deleteVehicle _x;
	} forEach crew _plane;
	deleteVehicle _plane;
	deleteGroup (_vehicle select 2);

};
	
// SETUP PAVN LOGISTICS 
if (_faction == "PAVN") then {
	_supplySource = selectRandom [
		"supply_North", 
		"supply_West", 
		"supply_NorthWest",
		"supply_East"
	];
	_supplyVehicle = selectRandom [
		// Add class names of vehicles here 
		"vn_o_air_mi2_01_01"
	];
	_side = east;
	
	// Build supply convoy 
	_vehicle = [getMarkerPos _supplySource, 0, _supplyVehicle, _side] call BIS_fnc_spawnVehicle;
	_veh = _vehicle select 0;
	[_veh, "o_support", "Resupply"] spawn lmn_fnc_attachMarker;

	// Send convoy to location
	

	// Notify players
	systemchat format ["[PAVN Director] Supply convoy dispatched from %1 to Logistics HUB at %2.", _supplySource, _siteName];

	// Upon arrival, increase location supply
	

	// Increase supply level
	_currentSupply = ["read", [_location, "Supply"]] call _locDB;
	_newSupply = _currentSupply + 100;
	["write", [_location, "Supply", _newSupply]] call _locDB;
	systemchat format ["[PAVN Director] Supply convoy has arrived at %1. Supply level increased to %2.", _siteName, _newSupply];

	waitUntil {
		sleep 1;
		_distance = (getMarkerPos _supplySource) distance (getPos _plane);
		_distance < 200;
	};

	// Delete vehicle / Cleanup
	{
		// Current result is saved in variable _x
		deleteVehicle _x;
	} forEach crew _plane;
	deleteVehicle _plane;
	deleteGroup (_vehicle select 2);

};
