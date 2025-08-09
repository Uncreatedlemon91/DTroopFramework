comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;


// Set the player role variable for future use 
player setVariable ["playerRole", "Pilot"];

// Define items for the arsenal 
_items = [

];

// Open the Arsenal to allow customization 
[ArsenalBox, player] call ace_arsenal_fnc_openBox;
[ArsenalBox, _items] call ace_arsenal_fnc_addVirtualItems;
