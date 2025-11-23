// Moves a trigger to another part of the map. This is a virtual entity
params ["_trig", "_dest"];

// Define the distance at which to stop
_stopDistanceSq = 10 * 10; // Use squared distance for better performance (e.g., 10 meters)
_moveSpeed = 25; // Meters per second
_distance = (getPosWorld _trig) distance _dest;
_trig setvariable ["TriggerDest", _dest, true];

while {_distance > (_moveSpeed * 2)} do {
    // Check for the active status
    if !(_trig getVariable ["TriggerActive", false]) then {
        // Calculate the vector from the current position TO the destination
        private _dirVector = _dest vectorDiff getPosWorld _trig; // Corrected: _dest - _trig

        // Check if the trigger is close enough to stop
        if ((_dirVector select 0)^2 + (_dirVector select 1)^2 < _stopDistanceSq) exitWith {
             systemChat format ["Reached destination at %1", getPos _trig];
             _trig setVariable ["lmnTrigPosture", "Idle", true];
        };

        // systemChat format ["Moving to %1", _dest];
        _trig setVariable ["lmnTrigPosture", "Moving", true];
        
        // Normalize the vector (make it length 1)
        _dirNorm = vectorNormalized _dirVector;
        
        // Calculate the step size based on frame time and speed
        // time (deltaTime) * speed = step distance
        _step = _dirNorm vectorMultiply (_moveSpeed * (time - (_trig getVariable ["lmnLastTime", time])));
        
        // Update the position
        _trig setPosWorld (getPosWorld _trig vectorAdd _step); // Use setPosWorld for reliability
        
        // Update the last time for the next frame calculation
        _trig setVariable ["lmnLastTime", time];
    };
    
	// Update the distance variable 
	_distance = (getPosWorld _trig) distance _dest;

    // Use the engine's sleep command for better performance
    // 0 is usually sufficient for a quick loop in a while true/alive loop
    sleep 1; 
};

systemChat "Arrived!";
_trig setVariable ["lmnTrigPosture", "Waiting", true];