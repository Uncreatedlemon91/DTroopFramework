// Put this in init.sqf or your functions library
params ["_markerName", "_startPos", "_endPos", "_speedKPH", "_type"];

// 1. Start the Path Calculation
// "car" ensures it sticks to roads. "SAFE" ensures it uses normal driving logic.
_agent = calculatePath [_type, "SAFE", _startPos, _endPos];

// 2. Pass arguments to the agent so we can use them inside the Event Handler
_agent setVariable ["moveArgs", [_markerName, _speedKPH]];

// 3. Define what happens when the path is found
_agent addEventHandler ["PathCalculated", {
	params ["_agent", "_path"];
	
	// Retrieve our args
	_args = _agent getVariable "moveArgs";
	_mkr  = _args select 0;
	_kph  = _args select 1;

   	// Convert Speed to Meters Per Second
	// Formula: Speed / 3.6
	_mps = _kph / 3.6;
	// _path deleteAt 0;

	// Spawn a new thread to handle the movement loop
	[_path, _mkr, _mps] spawn {
		params ["_waypoints", "_marker", "_speed"];

		// CHECK: If no path found (island to island?), exit
		if (count _waypoints == 0) exitWith { systemChat "No road path found!"; };

		// LOOP through the waypoints
		// We go to (count - 2) because we are always looking at "current" and "next"
		for "_i" from 1 to (count _waypoints - 2) do {

			// Cancel loop if the unit is activated
			_activeUnitData = LemonActiveSquads get _marker;
			if (_activeUnitData select 4) exitWith {SystemChat "Unit Active, exiting loop"};
			
			// Get the two points we are traveling between
			_currentSeg = _waypoints select _i;
			_nextSeg    = _waypoints select (_i + 1);

			// 1. SNAP the marker to the current road node
			_marker setMarkerPos _currentSeg;

			// 2. CALCULATE how long it takes to drive this specific segment
			_segmentDist = _currentSeg distance _nextSeg;
			
			// Time = Distance / Speed
			_sleepTime = _segmentDist / _speed;

			// 3. WAIT that amount of time (Realism)
			sleep _sleepTime;
		};

		// Final Step: Snap to the very last point
		_marker setMarkerPos (_waypoints select (count _waypoints - 1));
	};
}];