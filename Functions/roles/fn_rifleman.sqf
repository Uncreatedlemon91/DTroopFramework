params ["_unit"];

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "vn_m16";
_unit addPrimaryWeaponItem "vn_b_m16";
_unit addPrimaryWeaponItem "vn_m16_20_mag";

comment "Add containers";
_unit forceAddUniform "U_Simc_TCU_mk3_trop";
_unit addVest "V_Simc_56_alt";
_unit addBackpack "B_simc_pack_trop_flak_4_alt";
_unit addHeadgear "H_Simc_M1C_bitch_Cl";
_unit addGoggles "G_simc_US_Bandoleer_flak_556_left";

comment "Add items";
_unit linkItem "vn_b_item_compass";
_unit linkItem "vn_b_item_watch";
_unit linkItem "anduk_2_addon";

[_unit] remoteExec ["lmn_fnc_savePlayer", 2];