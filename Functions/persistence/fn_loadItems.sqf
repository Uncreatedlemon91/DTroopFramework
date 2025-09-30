_db = ["new", format ["Player Items %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// apply saved vehicle locations back to the server 
{
	if (_x == false) then {}
	else {
		_data = ["read", [_x, "Item Info"]] call _db;
		_type = _data select 0;
		_pos = _data select 1;
		_dir = _data select 2;
		_dmg = _data select 3;
		_items = _data select 4;
		_ammo = _data select 5;
		_weps = _data select 6;

		// Spawn vehicle replica 
		_item = _type createVehicle _pos;
		_item allowDamage false;
		clearItemCargoGlobal _item;
		clearMagazineCargoGlobal _item;
		clearBackpackCargoGlobal _item;
		clearWeaponCargoGlobal _item;
		_item setDir _dir;
		_item setDamage [_dmg, false, objNull, objNull];

		// Add cargo / Inventory of the vehicle back 
		_items params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_item addItemCargoGlobal [_classes select _i,_count select _i]
		};

		_ammo params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_item addMagazineCargoGlobal [_classes select _i,_count select _i]
		};

		_weps params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_item addWeaponCargoGlobal [_classes select _i,_count select _i]
		};
		
		["deleteSection", _x] call _db;
		[_item] remoteExec ["lmn_fnc_setupItems", 0, true];
		[_item] remoteExec ["lmn_fnc_saveItem", 2];
		_item allowDamage true;
	};
} forEach _sections;

// systemChat "[DB] Items Loaded";