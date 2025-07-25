comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add weapons";
player addWeapon "vn_m127";
player addSecondaryWeaponItem "vn_m127_mag";
player addWeapon "vn_m1911";
player addHandgunItem "vn_m1911_mag";

comment "Add containers";
player forceAddUniform "U_Simc_TCU_mk3_tuck_nom";
player addVest "vn_b_vest_aircrew_03";
player addHeadgear "vn_b_helmet_svh4_02_01";
player addGoggles "G_Nomex_desu_cut";

comment "Add items";
player linkItem "vn_b_item_map";
player linkItem "vn_b_item_compass";
player linkItem "vn_b_item_watch";
