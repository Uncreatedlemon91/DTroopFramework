// Saves the hashmap to the database 
_db = ["new", "Battalions"] call oo_inidbi;
while {true} do {
	{
		["write", [_x, "Data", _y]] call _db;
		sleep 0.01;	
	} forEach LemonBattalions;

	// Notify the admin 
	//["[Battalions] - Saved"] remoteExec ["systemChat", 0];

	// Sleep before saving again 
	sleep 10;
};