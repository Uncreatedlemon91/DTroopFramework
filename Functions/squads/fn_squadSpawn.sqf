// Function to spawn a squad near a squad trigger 
params ["_trig"];

// Get the variables from the trigger 
_squadType = _trig getVariable "TriggerSquad";
_faction = _trig getVariable "TriggerFaction";
_veterancy = _trig getVariable "TriggerVeterancy";
_destination = _trig getVariable "TriggerDest";
_active = _trig getVariable "TriggerActive";

// Exit if the trigger is active already 
if (_active) exitWith {systemChat "Trigger already Active!"};

// Set Trigger to active 
_trig setVariable ["TriggerActive", true];

// Translate Faction to Side 
_side = "";
switch (_faction) do {
	case "USA": {_side = west};
	case "PAVN": {_side = east};
};

// Define the group to be spawned in
_units = [_squadType, _faction] call lmn_fnc_getGroupDetails;

// Spawn the group and assign values 
_spawnPos = [position _trig, 0, 200, 10, 0, 0] call BIS_fnc_findSafePos;
_group = createGroup _side;
_group deleteGroupWhenEmpty true;
{
	_unitClass = getText (_x >> 'vehicle');
	_vehicleClasses = ["Tank Squads", "Mechanized Squads"];
	_unit = "";
	if (_squadType in _vehicleClasses) then {
		// The unit is vehicle based 
		_spawnPos = [_spawnPos, 0, 150, 10, 0, 0] call BIS_fnc_findSafePos;
		_unit = [_spawnPos, 0, _unitClass, _group] call BIS_fnc_spawnVehicle;
		zeus addCuratorEditableObjects [[_unit select 0], true];
	} else {	
		// The unit is infantry based.
		_unit = _group createUnit [_unitClass, _spawnPos, [], 0, "NONE"];
		_unit setSkill ["general", _veterancy];
		_unit setSkill ["aimingAccuracy", (_veterancy - 0.2)];
		_unit setSkill ["spotDistance", 1];
		_unit setSkill ["spotTime", 0.8];
		_unit setSkill ["courage", _veterancy];
		_unit setSkill ["reloadSpeed", _veterancy];
		_unit setSkill ["commanding", _veterancy];
		zeus addCuratorEditableObjects [[_unit], true];
	};	
	sleep 0.05;
} forEach _units;

_activeGroups = _trig getVariable ["ActiveGroups", []];
_activeGroups pushback _group;
_trig setVariable ["ActiveGroups", _activeGroups, true];

// Provide orders to the squad 
[_group, _destination, 50] call BIS_fnc_taskPatrol;