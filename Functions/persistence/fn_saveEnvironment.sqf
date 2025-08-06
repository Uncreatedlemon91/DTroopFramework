// Saves the weather to the environment database 
_db = ["new", format ["World Environment %1 %2", missionName, worldName]] call oo_inidbi;
["write", ["Info", "Wind", wind]] call _db;
["write", ["Info", "Wind Direction", windDir]] call _db;
["write", ["Info", "Wind Strength", windstr]] call _db;
["write", ["Info", "Rain", rain]] call _db;
["write", ["Info", "Fog", fog]] call _db;
["write", ["Info", "Gusts", gusts]] call _db;
["write", ["Info", "Overcast", overcast]] call _db;
["write", ["Info", "Waves", waves]] call _db;
["write", ["Info", "Humidity", humidity]] call _db;
["write", ["Info", "Date", date]] call _db;