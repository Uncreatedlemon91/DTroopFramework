// Saves the Hashmap to the database on a routine basis 
_db = ["new", "Locations"] call oo_inidbi;
while {true} do {
	{
		["write", [_x, "Data", _y]] call _db;
		sleep 0.01;
	} forEach LemonLocations;

	// Notify the admin 
	["[Locations] - Saved"] remoteExec ["systemChat", 0];

	// Sleep before saving again 
	sleep 300;
};