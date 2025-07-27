// Ambush is spawned 
params ["_trg"];

// Unpack variables 
_ambush = _trg getVariable "ambush";
_location = _trg getVariable "attachedLocation";
_ambushID = _trg getVariable "ambushID";
_ambushType = _ambush select 0;
_pos = _ambush select 1;
_countOfTroops = _ambush select 2;
_hasEmplacement = _ambush select 3;
_hasMine = _ambush select 4;

// Spawn the infantry 
_units = [];
_grp = createGroup east;
_grp deleteGroupWhenEmpty true;

for "_i" from 1 to _countOfTroops do {
	_unitClass = selectRandom (lmn_PAVN select 0);
	_unit = _grp createUnit [_unitClass, _pos, [], 20, "NONE"];
	_unit setUnitPos "DOWN";
	_unit setVariable ["ambushID", _ambushID];
	_unit setVariable ["attachedLocation", _location];
	_unit setSkill random 1;
	_unit addEventHandler [
		"Killed", 
		{
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
			_ambushID = _unit getVariable "ambushID";
			_location = _unit getVariable "attachedLocation";
			_data = ["read", [_location, format ["Ambush-%1", _ambushID]]] call _locDB;
			_newData = [_data select 0, _data select 1, ((_data select 2) - 1), _data select 3, _data select 4];
			["write", [_location, format ["Ambush-%1",_ambushID], _newData]] call _locDB;
		}
	];
};

_grp setFormation selectRandom ["VEE", "LINE", "ECH LEFT", "ECH RIGHT"];
_grp setCombatMode "RED";
[_grp, _pos] call BIS_fnc_taskDefend;

// Spawn the emplacement 
if (_hasEmplacement) then {
	_spawnPos = [_pos, 10, 85, 5, 0, 5] call BIS_fnc_findSafePos;
	_class = selectRandom (lmn_PAVN select 2);
	_turret = [_spawnPos, 0, _class, east] call BIS_fnc_spawnVehicle;
	_dirToKillZone = _spawnPos getRelDir _pos;
	_turret setDir _dirToKillzone;
	(_turret select 0) addEventHandler [
		"Killed", 
		{
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;
			_ambushID = _unit getVariable "ambushID";
			_location = _unit getVariable "attachedLocation";
			_data = ["read", [_location, format ["Ambush-%1", _ambushID]]] call _locDB;
			_newData = [_data select 0, _data select 1, _data select 2, false, _data select 4];
			["write", [_location, format ["Ambush-%1",_ambushID], _newData]] call _locDB;
		}
	];
};

// Set the mine/s
if (_hasMine) then {
	
};