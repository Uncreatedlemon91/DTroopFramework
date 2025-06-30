// load the saved markers from the mission namespace 
if (resetBodyMarkers) then {
	missionProfileNameSpace setVariable ["bodyMarkers", Nil];
	saveMissionProfileNameSpace;
};

_markers = missionProfileNameSpace getVariable "bodyMarkers";
systemChat format ["%1", _markers];
{
	// Current result is saved in variable _x
	_mkr = createMarkerLocal [(_x select 0), (_x select 4)];
	_mkr setMarkerTypeLocal (_x select 1); 
	_mkr setMarkerColorLocal (_x select 2);
	_mkr setMarkerText (_x select 3);
	_mkr setMarkerAlphaLocal 0;
	if (debugMode) then {
		_mkr setMarkerAlpha 1;
	};
} forEach _markers;
