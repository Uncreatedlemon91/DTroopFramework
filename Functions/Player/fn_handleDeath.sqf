// Handles player death, removes life and adds a persistent marker to the world 
params ["_unit", "_corpse"];

// Get information
_uid = getPlayerUID _unit;
_profile = missionProfileNameSpace getVariable format ["%1-%2", _uid, missionName];

// Reduce player lives left by 1 
_lives = _unit getVariable ["livesLeft", 5];
_unit setVariable ["livesLeft",  (_lives - 1)];

// Notify the player how many lives they have left. 
hint format ["You have %1 lives left", _lives];

// If the player has no lives left, put them in spectator 
if ((_profile select 3) < 1) then {
	["Initialize", [player]] call BIS_fnc_EGSpectator;
	deletevehicle _unit;
};

// Set Marker Variables
_mkrName = format ["%1-%2-BodyMarker", _uid, position _corpse];
_mkrType = "KIA";
_mkrColor = "COLORRED";
_mkrText = format ["Corpse - %1", name _unit];
_mkrPos = position _corpse;
_mkrAlpha = 0;

// Create the marker on the corpse location
_mkr = createMarkerLocal [_mkrName, _mkrPos];
_mkr setMarkerTypeLocal _mkrType; 
_mkr setMarkerColorLocal _mkrColor;
_mkr setMarkerText _mkrText;
_mkr setMarkerAlpha _mkrAlpha;

// Save the marker to the server save profile.
_mkrData = [_mkrName, _mkrType, _mkrColor, _mkrText, _mkrPos];
_currentData = missionProfileNamespace getVariable ["bodyMarkers", []];
_currentData pushBack _mkrData;
missionProfileNameSpace setVariable ["bodyMarkers", _currentData];
saveMissionProfileNamespace;