// Create a trigger for troops moving on the map 
params ["_object", "_targetPos"];

// --- Loop as long as the object is further than the threshold
while {(_object distance _targetPos) > 5} do {
    // 1. Get current position
    _currentPos = getPos _object;

    // 2. Get direction to target
    _direction = (_targetPos vectorAdd (_currentPos vectorMultiply -1)) vectorNormalized;
    
    // 3. Calculate the new position
    _moveVector = _direction vectorMultiply 5;
    _newPos = _currentPos vectorAdd _moveVector;

    // 4. Set the new position
    _object setPosition _newPos;

    // 5. Wait
    sleep 5;
};

// --- Final step: Snap exactly to the target
_object setPosition _targetPos;
_destination = _object getVariable "TriggerDestination";

_oldTroopLevel = _destination select 3;
_newTroopLevel = _oldTroopLevel + _groupCount;
_destination set [3, _newTroopLevel];

// Sync database 
[_destination] remoteExec ["lmn_fnc_saveLocation", 2];