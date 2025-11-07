// Sets the location's faction upon creation 
params ["_loc"];

// Find if the location is positioned inside an Area Marker 
_faction = "VN_PAVN";
_flagType = "vn_flag_PAVN";

if (position _loc inArea "southAO") then {
	_faction = selectRandomWeighted ["VN_MACV", 0.4, "VN_ARVN", 0.6];
	if (_faction == "VN_ARVN") then {
		_flagType = "vn_flag_arvn";
	} else {
		_flagType = "vn_flag_usa";
	}
};
_return = [_faction, _flagType];

// Return result
_return;
