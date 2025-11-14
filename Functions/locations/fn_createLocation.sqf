// Creates a location and saves it to the database 
params ["_loc"];

// Define the databases being used
_locDB = ["new", format ["Locations %1 %2", missionName, worldName]] call oo_inidbi;

// Define the variables for the location 
_id = [] call lmn_fnc_setLocationID;

_siteType = type _loc;
["write", [_id, "Site Type", _siteType]] call _locDB;

_siteName = text _loc;
["write", [_id, "Site Name", _siteName]] call _locDB;

_position = position _loc;
["write", [_id, "Position", _position]] call _locDB;

_faction = [_loc] call lmn_fnc_setLocationFaction;
["write", [_id, "Faction", _faction select 0]] call _locDB;

_heatLevel = 0;
["write", [_id, "Heat Level", _heatLevel]] call _locDB;

_civCount = [_loc] call lmn_fnc_setCivilianCount;
["write", [_id, "Civilian Count", _civCount]] call _locDB;

switch (_faction) do {
	case "USA": {
		_security = round(random 100);
		["write", [_id, "Security", _security]] call _locDB;
	};
	case "PAVN": {
		_security = round(random -100);
		["write", [_id, "Security", _security]] call _locDB;
	};
};

_locationMarker = createMarker [format ["loc_%1", _id], _position];
["write", [_id, "Location Marker", _locationMarker]] call _locDB;

_supply = round (random 1000);
["write", [_id, "Supply", _supply]] call _locDB;

// Update the Marker 
_locationMarker setMarkerTypeLocal (_faction select 1);
_locationMarker setMarkerSize [0.5, 0.5];
