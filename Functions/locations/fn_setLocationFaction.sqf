// Sets the location's faction upon creation 
params ["_loc"];

// Find if the location is positioned inside an Area Marker 
_southAO = [];
_faction = "VN_PAVN";
_flagType = "vn_flag_PAVN";
{
	if (position _loc inArea _x) then {
		_faction = selectRandomWeighted ["VN_MACV", 0.3, "VN_ARVN", 0.7];
		if (_faction == "VN_ARVN") then {
			_flagType = "vn_flag_arvn";
		} else {
			_flagType = "vn_flag_macv";
		}
	};
} forEach _southAO;

// Return result
_result = [_faction, _flagType];