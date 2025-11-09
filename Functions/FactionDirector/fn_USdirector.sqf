// US Forces Director Logic
systemChat "[US Director] Starting US Forces Director...";
while {true} do {
	// Check Locations for supply needs
	_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
	_sections = "getSections" call _locDB;

	// Get updated list of all locations 
	_locations = [];
	_locationsLowSupply = [];
	_locationsHighHeat = [];
	_locationsMedHeat = [];
	_locationsLowHeat = [];
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
			if (_heatLevel < 200) then {
				_locationsLowHeat pushback _x;
				systemchat format ["[US Director] Location %1 has low enemy activity (%2).", _name, _heatLevel];
			};
			if ((_heatLevel > 199) AND (_heatLevel < 600)) then {
				_locationsMedHeat pushback _x;
				systemchat format ["[US Director] Location %1 has medium enemy activity (%2).", _name, _heatLevel];
			};
			if (_heatLevel > 599) then {
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
		_supplyLevel = ["read", [_x, "Supply"]] call _locDB;
		if (_supplyLevel < 800) then {
			// Send a supply convoy to this location 
			[_x, "USA"] remoteExec ["lmn_fnc_createHUBsupply", 2];
			systemchat format ["[US Director] Sending supply convoy to Logistics HUB at %1.", ["read", [_x, "Site Name"]] call _locDB];
			sleep 2;
		};

		// Phase Two : Resupply from HUB to low supply locations
		_hub = _x;
		{
			if (_supplyLevel > 200) then {
				[_x, "USA", _hub] remoteExec ["lmn_fnc_createConvoy", 2];
				systemchat format ["[US Director] Sending supply convoy to location %1.", ["read", [_x, "Site Name"]] call _locDB];
			};
			sleep 10;
		} forEach _locationsLowSupply;

		// Phase Three: Looks to create a new Battalion if there are remainder of supplies at the HUB
		if (_supplyLevel > 400) then {
			["USA", _hub] remoteExec ["lmn_fnc_createBattalion", 2];
			_newSupply = _supplyLevel - 300;
			["write", [_x, "Supply", _newSupply]] call _locDB;
			systemchat format ["[US Director] Creating new Battalion at Logistics HUB at %1.", ["read", [_x, "Site Name"]] call _locDB];
		};
		sleep 2;
	} forEach _locationsLogiHub;

	// Phase Four: Get Battalion updates 
	_battalionDB = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;
	_battalions = "getSections" call _battalionDB;
	_usBattalions = [];
	_reserves = [];
	{
		_faction = ["read", [_x, "Faction"]] call _battalionDB;
		_posture = ["read", [_x, "Posture"]] call _battalionDB;
		if (_faction == "USA") then {
			_usBattalions pushback _x;
			if (_posture == "Reserves") then {
				_reserves pushback _x;
			};
		};
	} forEach _battalions;

	// Phase Six: Deploy Reserves
	{
		_location = selectRandom _locations;
		[_x, _location] remoteExec ["lmn_fnc_deployBattalion", 2];
		systemchat format ["[US Director] Deploying Battalion %1 to location %2.", _battalionToDeploy, ["read", [_x, "Site Name"]] call _locDB];
		sleep 2;
	} forEach _reserves;

	// Loop delay
	sleep 10;
};