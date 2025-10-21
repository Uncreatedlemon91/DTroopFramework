// Loads the locations from the database 
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _locDB;

{
	_data = ["read", [_x, "Data"]] call _locDB;

	/*
	0. text _loc,
	1. position _loc,
	2. _faction,
	3. _troopCount,
	4. _maxTroopCount,
	5. _supplyLevel,
	6. _siteType,
	7. _security,
	8. _flag,
	9. _civCount
	*/

	// Build the trigger at the location 
	_trig = createTrigger ["EmptyDetector", _data select 1, true];
	_trig setTriggerArea [1500, 1500, 0, false, 300];
	_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trig setTriggerStatements [
		"this", 
		"[thisTrigger] remoteExec ['lmn_fnc_tdTick', 2]",
		"thisTrigger setVariable ['Activated', false]"
	];

	// Create Marker 
	_mkr = createMarker [_data select 0, _data select 1];
	_mkr setMarkerType (_data select 8);
	_mkr setMarkerSize [(_data select 9), (_data select 9)];;
	_mkr setMarkerAlpha 0.4;

	// Set Trigger Variables 
	_trig setVariable ["Location", _x, true];
	_trig setVariable ["Faction", _data select 2, true];
	_trig setVariable ["TroopCount", _data select 3, true];
	_trig setVariable ["SiteType", _data select 6, true];
	_trig setVariable ["MaxTroopCount", _data select 4, true];
	_trig setVariable ["SupplyLevel", _data select 5, true];
	_trig setVariable ["Security", _data select 7, true];
	_trig setVariable ["CivCount", _data select 9, true];
	_trig setVariable ["Marker", _mkr, true];
	_trig setVariable ["Activated", false, true];
} forEach _sections;