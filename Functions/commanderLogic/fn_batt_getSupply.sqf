// Orders an Infantry squad to go to a nearby location in order to get supplies
params ["_faction", "_squad", "_position", "_markerType", "_batt"];

// Select a nearby location to get supply 
_nearLoc = [_position, 1000, _faction] call lmn_fnc_getNearLocations;
_dest = _nearLoc select 0;
_dest = selectRandom _dest;
_destID = _dest select 0;
_dest = _dest select 1;

// Setup a virtual instance of the troop 
_trig = createTrigger ["EmptyDetector", _position, true];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerArea [250, 250, 0, false, 200];
_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_spawnSquad', 2]",
	"thisTrigger setVariable ['lmn_TrigActive', false]"
];

// Setup Trigger Variables 
_trig setVariable ["lmn_TrigSquad", _squad];
_trig setVariable ["lmn_TrigActive", false];
_trig setVariable ["lmn_TrigDest", _dest];

// Attach a marker to the trigger 
[_trig, _markerType, "Supply Mission"] spawn lmn_fnc_attachMarker;

// Move the trigger over time to the destination 
[_trig, _dest] remoteExec ["lmn_fnc_moveTrigger", 2];

// Wait until we arrive at the location 
while {(getPosWorld _trig distance _dest) > 50} do {
	sleep 5;
};

// Get destination supplies 
_db = _locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
_supply = ["read", [_destID, "Supply"]] call _db;

// Remove supply from the destination
if (_supply > 75) then {
	_newSupply = _supply - 75;
	["read", [_destID, "Supply"]] call _db;
};

// Order the troops back to their home position 
[_trig, _position] remoteExec ["lmn_fnc_moveTrigger", 2];

// Wait until the squad returns 
while {(getPosWorld _trig distance _dest) > 50} then {
	sleep 5;
};

// Return the squad to the battalion 
_db = ["new", format ["Battalions %1 %2", missionName, worldName]] call oo_inidbi;
_comp = ["read", [_batt, "Composition"]] call _db;
{
	_type = _x select 0;
	_count = _x select 1;
	if (_type == _squad) then {
		_count = _count + 1;
	};
} forEach _comp;
