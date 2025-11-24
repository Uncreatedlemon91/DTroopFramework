// US Forces Director Logic
systemChat "[PAVN Director] Starting PAVN Forces Director...";
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
		if (_faction == "PAVN") then {
			_locations pushback _x;

			// Check Supply Level 
			_supplyLevel = ["read", [_x, "Supply"]] call _locDB;
			if (_supplyLevel < 250) then {
				_locationsLowSupply pushback _x;
				// systemchat format ["[PAVN Director] Location %1 has low supplies (%2).", _name, _supplyLevel];
			};

			// Check Heat Level 
			_heatLevel = ["read", [_x, "Heat Level"]] call _locDB;
			if (_heatLevel < 26) then {
				_locationsLowHeat pushback _x;
				// systemchat format ["[US Director] Location %1 has low enemy activity (%2).", _name, _heatLevel];
			};
			if ((_heatLevel > 25) AND (_heatLevel < 75)) then {
				_locationsMedHeat pushback _x;
				// systemchat format ["[US Director] Location %1 has medium enemy activity (%2).", _name, _heatLevel];
			};
			if (_heatLevel > 75) then {
				_locationsHighHeat pushback _x;
				// systemchat format ["[US Director] Location %1 has high enemy activity (%2).", _name, _heatLevel];
			};

			// Check Security Level 
			_securityLevel = ["read", [_x, "Security"]] call _locDB;
			if (_securityLevel < 25) then {
				_locationsLowSecurity pushback _x;
				// systemchat format ["[PAVN Director] Location %1 has low security (%2).", _name, _securityLevel];
			};

			_siteType = ["read", [_x, "Site Type"]] call _locDB;
			if (_siteType == "NameCity") then {
				_locationsLogiHub pushback _x;
				// systemchat format ["[PAVN Director] Location %1 is a Logistics HUB.", _name];
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
			[_x, "PAVN"] remoteExec ["lmn_fnc_createHUBsupply", 2];
			systemchat format ["[PAVN Director] Sending supply convoy to Logistics HUB at %1.", ["read", [_x, "Site Name"]] call _locDB];
			sleep 0.02;
		};

		// Phase Two : Resupply from HUB to low supply locations
		_hub = _x;
		{
			if (_supplyLevel > 200) then {
				[_x, "PAVN", _hub] remoteExec ["lmn_fnc_createConvoy", 2];
				systemchat format ["[PAVN Director] Sending supply convoy to location %1.", ["read", [_x, "Site Name"]] call _locDB];
			};
			sleep 10;
		} forEach _locationsLowSupply;

		// Phase Three: Looks to create a new Battalion if there are remainder of supplies at the HUB
		_Bdb = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;
		_batts = "getSections" call _Bdb;
		_battalionCount = 0;
		{
			_faction = ["read", [_x, "Faction"]] call _bdb;
			if (_faction == "PAVN") then {
				_battalionCount = _battalionCount + 1;
			};
		} forEach _batts;
		_calBattalions = (count _locations) / 3;
		if ((_supplyLevel > 400) AND (_battalionCount < _calBattalions)) then {
			["PAVN", _hub] remoteExec ["lmn_fnc_createBattalion", 2];
			_newSupply = _supplyLevel - 300;
			["write", [_x, "Supply", _newSupply]] call _locDB;
			systemchat format ["[PAVN Director] Creating new Battalion at Logistics HUB at %1.", ["read", [_x, "Site Name"]] call _locDB];
		};
		sleep 2;
	} forEach _locationsLogiHub;

	// Loop delay
	sleep 180;
};