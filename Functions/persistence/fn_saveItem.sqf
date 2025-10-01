// Save Items spawned in by Logi point  
params ["_item"];

// Setup database
_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;

// Setup Index 
_localIndex = _item getVariable "IndexVar";

// Build index if none exists
if (isNil "_localIndex") then {
	// This is a new item, as it as an entry to the database
	_index = ["read", ["IndexCount", "Count", 0]] call _db;
	if (_index == 0) then {
		["write", ["IndexCount", "Count", 0]] call _db;
	};
	_localIndex = _index + 1;
	["write", ["IndexCount", "Count", _localIndex]] call _db;
};

// Get details
_pos = getPosATL _item;
_dir = getDir _item;
_dmg = damage _item;
_type = typeOf _item;
_items = getItemCargo _item;
_ammo = getMagazineCargo _item;
_weps = getWeaponCargo _item;

// Save to database
_data = [_type, _pos, _dir, _dmg, _items, _ammo, _weps];
["write", [_localIndex, "Item Info", _data]] call _db;