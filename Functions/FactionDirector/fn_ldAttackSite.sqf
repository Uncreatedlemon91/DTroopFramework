// Function to prep units to attack another zone 
params ["_source", "_destination"];

// Get Variables 
_faction = _source select 2;
_troopCount = _source select 3;
_spawnSide = "";
_cfgClass = "";

// Change variables based on faction 
switch (_faction) do {
	case "USA": {_spawnSide = west; _cfgClass = configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sog"};
	case "PAVN": {_spawnSide = east; _cfgClass = configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_field"};
	case "ARVN": {_spawnSide = independent; _cfgClass = configfile >> "CfgGroups" >> "Indep" >> "VN_ARVN" >> "vn_i_group_men_ranger"};
};

// Set spawn location and spawn unit 
_spawnPos = [_source select 1, 0, 100, 5, 0, 3] call BIS_fnc_findSafePos;
_spawnPos = [_spawnPos select 0, _spawnPos select 1, 0];
_squad = selectRandom ("true" configClasses (_cfgClass));
_units = "true" configClasses (_squad);

// Create a trigger that will move to the location 
_trig = createTrigger ["EmptyDetector", _spawnPos];
_trig setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trig setTriggerArea [350, 350, 0, false, 100];
_trig setVariable ["TriggerUnits", _units, true];
_trig setVariable ["TriggerSpawnSide", _spawnSide, true];
_trig setVariable ["TriggerSource", _source, true];
_trig setVariable ["TriggerDestination", _destination, true];

[_trig, _destination select 1] remoteExec ["lmn_fnc_triggerToMove", 2];

_trig setTriggerStatements [
	"this", 
	"[thisTrigger] remoteExec ['lmn_fnc_ldSpawnGroup', 2]",
	"thisTrigger setVariable ['Activated', false, true]"
];

// Remove the count of troops from the trigger 
_groupCount = count _units;
_newTroopCount = _troopCount - _groupCount;
_source set [3, _newTroopCount];

// Sync database 
[_source] remoteExec ["lmn_fnc_saveLocation", 2];

// Delete the unit and add them to the destination if they get there succesfully 
_travelling = true;
while {_travelling} do {
	_ldr = leader _troopGroup;
	_ldrPos = getPos _ldr;
	_dest = _destination select 1;
	_dist = _ldrPos distance2D _dest;
	if (_dist < 30) then {
		_travelling = false;
	}; 
	sleep 5;
};
{
	deleteVehicle _x;
} forEach units _troopGroup;

_oldTroopLevel = _destination select 3;
_newTroopLevel = _oldTroopLevel - _groupCount;
_destination set [3, _newTroopLevel];

// Sync database 
[_destination] remoteExec ["lmn_fnc_saveLocation", 2];