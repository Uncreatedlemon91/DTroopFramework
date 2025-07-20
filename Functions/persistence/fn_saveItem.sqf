// Save Items spawned in by Logi point  
params ["_item"];

// Setup database
_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;

// Get details
_pos = getPosATL _item;
_dir = getDir _item;
_dmg = damage _item;
_type = typeOf _item;
_netId = netId _item;
_mags = magazinesAllTurrets [_item, true];
{
	_x deleteAt 3;
	_x deleteAt 4;
} forEach _mags;
_items = getItemCargo _item;
_ammo = getMagazineCargo _item;
_weps = getWeaponCargo _item;

// Save to database
_data = [_type, _pos, _dir, _dmg, _mags, _items, _ammo, _weps];
["write", [_netId, "Item Info", _data]] call _db;