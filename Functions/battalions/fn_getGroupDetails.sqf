// Gets spawned units and group information 
params ["_groupType", "_faction"];

_groupClass = "";
if (_faction == "USA") then {
	switch (_groupType) do {
		case "Infantry Squads": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_army" >> "vn_b_group_men_army_01");
		};
		case "Recon Squads": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_men_sf" >> "vn_b_group_men_sf_01");
		};
		case "Tank Squads": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_armor_army" >> "vn_b_group_armor_army_02");
		};
		case "Mechanized Squads": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "West" >> "VN_MACV" >> "vn_b_group_mech_army" >> "vn_b_group_mech_army_09");
		};
	};
};

if (_faction == "PAVN") then {
	switch (_groupType) do {
		case "Infantry Squads": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_field" >> "vn_o_group_men_nva_field_01");
		};
		case "Special Forces": {
			_groupClass = "true" configClasses (configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_men_nva_dc" >> "vn_o_group_men_nva_dc_01");
		};
	};
};

// Export the unit
_groupClass;