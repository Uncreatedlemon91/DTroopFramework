// Moves a trigger to another part of the map. This is a virtual entity
params ["_trig", "_dest"];

while {alive _trig} do {
	if !(_trig getVariable "lmn_TrigActive") then {
		// systemChat "Moving!";
		_trig setVariable ["lmnTrigPosture", "Moving", true];
		_currentPos = getpos _trig;
		_dirVector = _currentPos vectorDiff _dest;
		_dirNorm = vectorNormalized _dirVector;
		_step = _dirNorm vectorMultiply 0.05;
		_newPos = _currentPos vectorAdd _step;
		_trig setPos _newPos;
	};
	sleep 0.05;
};