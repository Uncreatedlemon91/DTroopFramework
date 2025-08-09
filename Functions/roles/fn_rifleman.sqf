// Rifleman Loadout


// Set the player role variable for future use 
player setVariable ["playerRole", "Rifleman"];

// Define items for the arsenal 
_items = [

];

// Open the Arsenal to allow customization 
[ArsenalBox, player] call ace_arsenal_fnc_openBox;
[ArsenalBox, _items] call ace_arsenal_fnc_addVirtualItems;