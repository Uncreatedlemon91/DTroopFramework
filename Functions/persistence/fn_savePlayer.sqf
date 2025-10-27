// save the player character 
params ["_player", "_uid"];

// Setup databases for Wrecks and Player vehicles 
_db = ["new", format ["Player Profiles %1 %2", missionName, worldName]] call oo_inidbi;

// Get details
_pos = getPosATL _player;
_dir = getDir _player;
_name = name _player;
_loadout = getUnitLoadout _player;
_medical = [_player] call ace_medical_fnc_serializeState;
_weapon = currentWeapon player;;

if (isNil "_uid") then {
	_uid = getPlayerUID _player;
};

// Save to database
_data = [_name, _pos, _dir, _uid, _loadout, _medical, _weapon];
["write", [_uid, "Player Info", _data]] call _db;

// Get map markers for the player 
_markers = allMapMarkers;
_saveMarker = [];
{
	if ((markerAlpha _x) != 0.4) then {
		_markerName = str _x;
		_markerType = markerType _x;
		_markerAlpha = markerAlpha _x;
		_markerColor = markerColor _x;
		_markerText = markerText _x;
		_markerPos = getMarkerPos _x;
		_data = [
			_markerName, _markerType, _markerAlpha, _markerColor, _markerText, _markerPos
		];
		_saveMarker pushback _data;
	}
} forEach _markers;

// Save Markers to DB 
["deleteKey", [_uid, "Player Markers"]] call _db;
["write", [_uid, "Player Markers", _saveMarker]] call _db;

