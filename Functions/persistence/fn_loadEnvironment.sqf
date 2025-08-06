// Saves the weather to the environment database 
_db = ["new", format ["World Environment %1 %2", missionName, worldName]] call oo_inidbi;
_wind = ["read", ["Info", "Wind"]] call _db;
_windDir = ["read", ["Info", "Wind Direction"]] call _db;
_windStr = ["read", ["Info", "Wind Strength"]] call _db;
_rain = ["read", ["Info", "Rain"]] call _db;
_fog = ["read", ["Info", "Fog"]] call _db;
_gusts = ["read", ["Info", "Gusts"]] call _db;
_overcast = ["read", ["Info", "Overcast"]] call _db;
_waves = ["read", ["Info", "Waves"]] call _db;
_humidity = ["read", ["Info", "Humidity"]] call _db;
_date = ["read", ["Info", "Date"]] call _db;

// Load the environment 
setWind [_wind select 0, _wind select 1];
0 setWindDir _windDir;
0 setWindStr _windStr;
0 setRain _rain;
0 setFog _fog;
0 setGusts _gusts;
0 setOvercast _overcast;
0 setWaves _waves;
simulSetHumidity _humidity;
setDate _date;
forceWeatherChange;