// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	_data = ["read", [_x, "Data"]] call _locDB;

	// Build the trigger at the location 
	_trig = createTrigger ["EmptyDetector", (_data select 1), true];
	_trig setTriggerArea [1000, 1000, 0, false, 300];
	_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_tdTick',2];",
	"thisTrigger setVariable ['Activated', false, true]"
];

	// Create Marker 
	_mkr = createMarker [str (_data select 1), _data select 1];
	_mkr setMarkerType (_data select 8);
	_mkr setMarkerSize [(_data select 9), (_data select 9)];;
	_mkr setMarkerAlpha 0.4;

	// Set Trigger Variables 
	_trig setVariable ["Location", _data select 11, true];
	_trig setVariable ["Activated", false, true];
	_trig setVariable ["Marker", _mkr, true];

	sleep 0.2;
} forEach _sections;