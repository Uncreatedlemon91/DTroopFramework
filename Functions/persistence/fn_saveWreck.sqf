// Saves a wreck to the database 
params ["_wreck"];

// Call the databases 
_vDB = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_wDB = ["new", format ["Player Wrecks %1 %2", missionName, worldName]] call oo_inidbi;

// Get the location and type of the unit  
_pos = getPosATL _wreck;
_type = typeOf _wreck;
_dir = direction _wreck;
_netID = netId _wreck;

// Save to the wreck DB 
_data = [_pos, _type, _dir];
["write", [_netId, "Wreck Info", _data]] call _wDB;

// Delete from the Vehicle DB 
["deleteSection", _netID] call _vDB;
