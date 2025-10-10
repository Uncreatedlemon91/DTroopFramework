// saveVehicle.sqf
params ["_veh"];

// Setup databases for Wrecks and Player vehicles 
_db = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;

// Setup Index 
_localIndex = _veh getVariable "IndexVar";

// Build index if none exists
if (isNil "_localIndex") then {
	// This is a new item, as it as an entry to the database
	_index = ["read", ["IndexCount", "Count", 0]] call _db;
	// systemChat format ["%1", _index];
	if (_index == 0) then {
		["write", ["IndexCount", "Count", 0]] call _db;
	};
	_localIndex = _index + 1;
	["write", ["IndexCount", "Count", _localIndex]] call _db;
	_veh setVariable ["IndexVar", _localIndex, true];
};

// Wait for damage and model to set  
sleep 5;

// Get details
_pos = getPosATL _veh;
_dir = getDir _veh;
_dmg1 = (getAllHitPointsDamage _veh) select 0;
_dmg2 = (getAllHitPointsDamage _veh) select 2;
_fuel = fuel _veh;
_type = typeOf _veh;
_mags = magazinesAllTurrets [_veh, true];
{
	_x deleteAt 3;
	_x deleteAt 4;
} forEach _mags;
_items = getItemCargo _veh;
_ammo = getMagazineCargo _veh;
_weps = getWeaponCargo _veh;

// Build core items from vehicles 
_data = [_type, _pos, _dir, _dmg1, _dmg2, _fuel, _mags, _items, _ammo, _weps];

// Save ACE Fuel base 
_fuelCargo = [_veh] call ace_refuel_fnc_getFuel;
if !(isNil "_fuelCargo") then {
	_data pushback _fuelCargo;
};

// Save to database
["write", [_localIndex, "Vehicle Info", _data]] call _db;
