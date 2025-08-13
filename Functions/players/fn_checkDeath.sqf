// Checks to see if the player has died today. If so, puts them into spectator mode 
params ["_player"];

_netID = netId _player;

// Check if dead 
_uid = getplayeruid _player;
_time = systemTime;
_dd = _time select 2;
_mm = _time select 1;
_yy = _time select 0;
_newTime = format ["%1-%2-%3", _mm, _dd, _yy];
_Ddb = ["new", format ["Player Deaths %1 %2", missionName, worldName]] call oo_inidbi;
_isDead = ["read", [_uid, _newTime]] call _Ddb;

if (_isDead == "Killed in Action") then {
	["You have already died today!"] remoteExec ["SystemChat", _netID];
	["Initialize", [_player]] call BIS_fnc_EGSpectator;
};
