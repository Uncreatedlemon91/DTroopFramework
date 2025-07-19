// Save Items spawned in by Logi point  
params ["_item"];

// Setup database
_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;

// Get details
_pos = getPosATL _veh;
_dir = getDir _veh;
_dmg = damage _veh;
_type = typeOf _veh;
_netId = netId _veh;
_mags = magazinesAllTurrets [_veh, true];
{
	_x deleteAt 3;
	_x deleteAt 4;
} forEach _mags;
_items = getItemCargo _veh;
_ammo = getMagazineCargo _veh;
_weps = getWeaponCargo _veh;

// Save to database
_data = [_type, _pos, _dir, _dmg, _mags, _items, _ammo, _weps];
["write", [_netId, "Item Info", _data]] call _db;