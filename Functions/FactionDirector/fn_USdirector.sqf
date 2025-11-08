// US Forces Director Logic
systemChat "[US Director] Starting US Forces Director...";

// Check Locations for supply needs
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

// Get updated list of all locations 
_locations = [];
_locationsLowSupply = [];
_locationsHighHeat = [];
_locationsLowSecurity = [];
_locationsLogiHub = [];

{
	// Check for the faction controlling the location 
	_faction = ["read", [_x, "Faction"]] call _locDB;
	_name = ["read", [_x, "Site Name"]] call _locDB;
	if (_faction == "VN_MACV") then {
		_locations pushback _x;

		// Check Supply Level 
		_supplyLevel = ["read", [_x, "Supply"]] call _locDB;
		if (_supplyLevel < 250) then {
			_locationsLowSupply pushback _x;
			systemchat format ["[US Director] Location %1 has low supplies (%2).", _name, _supplyLevel];
		};

		// Check Heat Level 
		_heatLevel = ["read", [_x, "Heat Level"]] call _locDB;
		if (_heatLevel > 700) then {
			_locationsHighHeat pushback _x;
			systemchat format ["[US Director] Location %1 has high enemy activity (%2).", _name, _heatLevel];
		};

		// Check Security Level 
		_securityLevel = ["read", [_x, "Security"]] call _locDB;
		if (_securityLevel < 300) then {
			_locationsLowSecurity pushback _x;
			systemchat format ["[US Director] Location %1 has low security (%2).", _name, _securityLevel];
		};

		_siteType = ["read", [_x, "Site Type"]] call _locDB;
		if (_siteType == "Airport") then {
			_locationsLogiHub pushback _x;
			systemchat format ["[US Director] Location %1 is a Logistics HUB.", _name];
		};
	};

	sleep 0.5;
} forEach _sections;

// With these lists, make decisions on what to do next

// Phase One: Resupply the HUBs 
{
	// Current result is saved in variable _x
	_supplyLevel = ["read", [_x, "Supply"]] call _locDB;
	if (_supplyLevel < 750) then {
		// Send a supply convoy to this location 
		[_x, "USA"] remoteExec ["lmn_fnc_createHUBsupply", 2];
		systemchat format ["[US Director] Sending supply convoy to Logistics HUB at %1.", ["read", [_x, "Site Name"]] call _locDB];
		sleep 2;
	};
} forEach _locationsLogiHub;

// Phase Two: Resupply Low supply locations 
{
	// Current result is saved in variable _x
	[_x, "USA"] remoteExec ["lmn_fnc_HUBtoLocSupply", 2];
	systemchat format ["[US Director] Sending supply convoy to location %1.", ["read", [_x, "Site Name"]] call _locDB];
	sleep 2;
} forEach _locationsLowSupply;