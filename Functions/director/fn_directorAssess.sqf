// Scans for logistics needs 

// Get data from the locations 
{
	_data = _y;
	// Check for the HUB locations 
	if (((_data select 6) == "Airport") AND ((_data select 0) == "USA") AND ((_data select 2) < 65)) then {
		// Call for a new supply mission to the airbase 
		_missionType = "Hub Supply";
		LemonTaskOrders set [format ["%1-%2", _missionType, _x], [_missionType, _x, _data]];
	};
	if (((_data select 6) == "NameCityCapital") AND ((_data select 0) == "ARVN") AND ((_data select 2) < 65)) then {
		// Call for a new supply mission to the City 
		_missionType = "Hub Supply";
		LemonTaskOrders set [format ["%1-%2", _missionType, _x], [_missionType, _x, _data]];
	};
	if (((_data select 6) == "NameCityCapital") AND ((_data select 0) == "PAVN") AND ((_data select 2) < 65)) then {
		// Call for a new supply mission to the City 
		_missionType = "Hub Supply";
		LemonTaskOrders set [format ["%1-%2", _missionType, _x], [_missionType, _x, _data]];
	};

	// Check for low level securities
	if ((_data select 5) < 25) then {
		// Creates an objective for the AI to send a patrol out
		_missionType = "Patrol";
		LemonTaskOrders set [format ["%1-%2", _missionType, _x], [_missionType, _x, _data]];
	};

	// IF the location is a HUB and has high supplies, form a new battalion 
	if ((_data select 2) > 40) then {
		// Create a battalion 
		[_data select 0, _data select 2] remoteExec ["lmn_fnc_battalionCreate", 2];
	};
} forEach LemonLocations;

systemChat "[Director] - Assessment Completed";