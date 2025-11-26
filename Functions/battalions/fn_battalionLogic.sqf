// Is the battalions' logic entity and decision maker 
params ["_batt"];

// Get the data 
_data = LemonBattalions get _batt;

// Check for locations that are low stability in the area 
{
	// A low security location that is friendly and nearby 
	if ((_y select 4 < 50) AND ((_y select 0) == (_data select 0)) AND (((_y select 2) distance (_data select 3)) < 3000)) then {
		LemonTaskOrders set [format ["%1-%2", "Security Patrol", _x], ["Security Patrol", _x, _data]];
		systemChat "Mission Assigned";
	};
} forEach LemonLocations;

// Check the mission board for missions, select one that is assigned to the battalion HQ 
_battOrders = [];
{
	// Find orders pertaining to this battalion 
	_yData = _y select 2;
	_isSame = [_yData, _Data] call BIS_fnc_arrayCompare;
	if (_isSame) then {
		_battOrders pushback _x;
	};
} forEach LemonTaskOrders;

// Select a batt order (for now, temporary) randomly
_tasking = selectRandom _battOrders;

// Get the mission details 
_missionPacket = LemonTaskOrders get _tasking;
_missionLocation = LemonLocations get ((LemonTaskOrders get _tasking) select 1);

// Execute the mission 
switch (_missionPacket select 0) do {
	case "Security Patrol": {[_missionPacket, _missionLocation] remoteExec ["lmn_fnc_squadSecurityPatrol", 2]};
};

