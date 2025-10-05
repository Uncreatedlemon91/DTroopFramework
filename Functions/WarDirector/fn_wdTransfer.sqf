// Transferes a garrison unit across to a friendly location 
params ["_target", "_source"];

// Get the location database
_gridDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Get current Garrison information 
_targetCurrent = ["read", [_target, "GarrisonSize"]] call _gridDB;
_sourceCurrent = ["read", [_source, "GarrisonSize"]] call _gridDB;	

// Transfer the garrison unit 
if (_sourceCurrent > 1) then {
	// Reduce the source location garrison size 
	_newSource = _sourceCurrent - 1;
	["write", [_source, "GarrisonSize", _newSource]] call _gridDB;

	// Increase the target location garrison size
	_newTarget = _targetCurrent + 1;
	["write", [_target, "GarrisonSize", _newTarget]] call _gridDB;

	systemChat format ["Transferring forces from %1 to %2", _source, _target];
} else {
	systemChat format ["Not enough forces at %1 to transfer", _source];
};