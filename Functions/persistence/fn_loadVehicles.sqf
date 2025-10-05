_db = ["new", format ["Player Vehicles %1 %2", missionName, worldName]] call oo_inidbi;
_sections = "getSections" call _db;

// apply saved vehicle locations back to the server 
{
	if !(_x == "IndexCount") then {
		_data = ["read", [_x, "Vehicle Info"]] call _db;
		_type = _data select 0;
		_pos = _data select 1;
		_dir = _data select 2;
		_dmg1 = _data select 3;
		_dmg2 = _data select 4;
		_fuel = _data select 5;
		_mags = _data select 6;
		_items = _data select 7;
		_ammo = _data select 8;
		_weps = _data select 9;
		_fuelCargo = _data select 10;

		// Spawn vehicle replica 
		_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
		_veh setVariable ["IndexVar", _x, true];
		_veh allowDammage false;
		_veh setDir _dir;
		clearItemCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;
		clearWeaponCargoGlobal _veh;
		_veh setFuel _fuel;
		_veh setPlateNumber _x;

		// Reapply ACE Fuel 
		if !(isNil "_fuelCargo") then {
			[_veh, _fuelCargo] call ace_refuel_fnc_setFuel;
		};
		
		// add Ammo
		{
			_mag = _x select 0;
			_turret = _x select 1;
			_magCount = _x select 2;
			_veh removeMagazinesTurret [_mag, _turret];
			_veh addMagazineTurret [_mag, _turret, _magCount];
		} forEach _mags;

		// Add cargo / Inventory of the vehicle back 
		_items params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_veh addItemCargoGlobal [_classes select _i,_count select _i]
		};

		_ammo params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_veh addMagazineCargoGlobal [_classes select _i,_count select _i]
		};

		_weps params ["_classes","_count"];
		for "_i" from 0 to count _classes - 1 do {
			_veh addWeaponCargoGlobal [_classes select _i,_count select _i]
		};

		// Re-add damage values 
		_destroyedParts = 0;
		_totalParts = count _dmg1;
		{
			_index = _dmg1 find _x;
			_hitpointValue = _dmg2 select _index;
			_veh setHitPointDamage [_x, _hitPointValue, false];
			if (_hitPointValue == 1) then {
				_destroyedParts = _destroyedParts + 1;
			}
		} forEach _dmg1;

		// If all parts are destroyed, then create a wreck instead.
		if (_destroyedParts == _totalParts) then {
			_veh setDamage [1, false];
		};
		_veh allowDammage true;

		// Setup Event Handlers 
		_veh addEventHandler ["GetIn", {
			params ["_vehicle", "_role", "_unit", "_turret"];
			[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
		}];

		_veh addEventHandler ["GetOut", {
			params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
			[_vehicle] remoteExec ["lmn_fnc_saveVehicle", 2];
		}];

		_veh addEventHandler ["ContainerClosed", {
			params ["_container", "_unit"];
			[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
		}];

		_veh addEventHandler ["ContainerOpened", {
			params ["_container", "_unit"];
			[_container] remoteExec ["lmn_fnc_saveVehicle", 2];
		}];

		_veh addEventHandler ["Killed", {
			params ["_unit", "_killer"];
			[_unit] remoteExec ["lmn_fnc_saveVehicle", 2];
		}];

		// Update the database 
		// deleteVehicle _veh;
		// ["deleteSection", _x] call _db;
		[_veh] remoteExec ["lmn_fnc_setupVehicle", 0, true];
		// [_veh] remoteExec ["lmn_fnc_saveVehicle", 2];
		sleep 0.5;
	};
} forEach _sections;


// systemChat "[DB] Vehicles Loaded";