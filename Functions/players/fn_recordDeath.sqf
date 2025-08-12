// Handles player death 
params ["_player"];

// Format data to be saved
_id = getPlayerUID _player;
_time = systemTime;
_dd = _time select 2;
_mm = _time select 1;
_yy = _time select 0;
_newTime = format ["%1-%2-%3", _mm, _dd, _yy];
_data = "Killed in Action";

// Save to Database
_db = ["new", format ["Player Deaths %1 %2", missionName, worldName]] call oo_inidbi;
["write", [_id, _newTime, _data]] call _db;
