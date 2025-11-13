// Checks the battalion strength and if they need reinforcements or not. 
params ["_comp", "_fullStrength"];

// Set Variables 
_needs = [];
_availableUnits = [];

if !([_comp, _fullStrength] call BIS_fnc_arrayCompare) then {
	// We are not full strength. Discover what we're missing by comparing to the full strength measurement.
	{
		_type = _x select 0;
		_count = _x select 1;
		{
			if ((_x select 0) == _type) then {
				_fullCount = _x select 1;
				if (_fullCount > _count) then {
					_needs pushback _type;
				};
			};
		} forEach _fullStrength;

		if (_count > 0) then {
			_availableUnits pushback _type;
		};
	} forEach _comp;
};

// Return 
_data = [_needs, _availableUnits];
_data;