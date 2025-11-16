// Sets the location's faction upon creation 
params ["_loc"];

// Find if the location is positioned inside an Area Marker 
_faction = "PAVN";
_flagType = "vn_flag_PAVN";

if (position _loc inArea "southAO") then {
	_faction = "USA";
	_flagType = "vn_flag_usa";
};
_return = [_faction, _flagType];

// Return result
_return;
