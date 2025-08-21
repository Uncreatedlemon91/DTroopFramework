// Spawns an ambush for the player. 
params ["_trg"];

// Check if trigger is already active
_active = _trg getVariable "Activated";
if (_active) exitwith {
	systemchat "[AMBUSH] Trigger already Active";
};

// change the activated flag 
_trg setVariable ["Activated", true, true];

// Get Trigger Variables 
_side = _trg getVariable "FactionSide";
_groupClass = _trg getVariable "ToSpawn";
_loc = _trg getVariable "attachedLocation";

// Spawn the unit 
_pos = position (selectRandom (nearestTerrainObjects [position _trg, ["HOUSE", "BUILDING"], 50, false, false]));
_pos = [_pos select 0, _pos select 1, 0];
_grp = createGroup _side;
_destroyed = false;
{
	// Current result is saved in variable _x
	_unit = _grp createUnit [_x, _pos, [], 5, "FORM"];
	zeus addCuratorEditableObjects [[_unit], true];
	sleep 0.5;
} forEach _groupClass;

// Give the unit orders to defend the point 
[_grp, _trg, 50, [], true, false, -1, false] call lambs_wp_fnc_taskGarrison;
_grp setBehaviour "SAFE";
_grp deleteGroupWhenEmpty true;

// Update the trigger to move with the unit leader 
while {_trg getVariable "Activated"} do {
	sleep 5;
	_ldr = leader _grp;
	_trg setpos (getPos _ldr);
	_count = 0;
	{
		if (alive _x) then {
			_count = _count + 1;
		};
	} forEach units _grp;
	if ((_count <= 2) AND !(_destroyed == true)) then {
		_destroyed = true;
		_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
		_currentCount = ["read", [_loc, "GarrisonSize"]] call _locDB;
		_newCount = _currentCount - 1;
		["write", [_loc, "GarrisonSize", _newCount]] call _locDB;

		// Flip the location if no more garrisons are active 
		if (_newCount <= 0) then {
			systemChat format ["Flipping Location %1", _loc];
			_allegiance = ["read", [_loc, "Allegiance"]] call _locDB;
			_newallegiance = [];
			switch (_allegiance) do {
				case "USA": {_newallegiance = "North"};
				case "ROK": {_newallegiance = "North"};
				case "AUS": {_newallegiance = "North"};
				case "NZ": {_newallegiance = "North"};
				case "North": {_newallegiance = selectRandom ["USA", "ROK", "AUS", "NZ"]};
			};

			// Get location raw data 
			_locPos = ["read", [_loc, "Pos"]] call _locDB;
			_loc = nearestLocation [_locPos, ""];

			// Delete current location data 
			["deleteSection", _loc] call _locDB;
			_mkr = ["read", [_loc, "Marker"]] call _locDB;
			deleteMarker _mkr;

			// Rebuild the location with new allegiance
			[_loc, _allegiance, true] remoteExec ["lmn_fnc_createLocation", 2];
		};
	}
};

// Despawn the AI when the trigger is no longer active
{
	deleteVehicle _x;
	sleep 0.2;
} forEach units _grp;
deleteGroup _grp;