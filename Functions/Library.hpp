class CfgFunctions
{
	class Lmn
	{
		class general 
		{
			class addActions {};
			class despawnAI {};
			class setCivActions {};
			class setEvents {};
			class setFactions {};
			class setupItems {};
			class setupVehicle {};
		};

		class locations 
		{
			class createLocation {};
			class setupLocations {};
		};

		class logi
		{
			class spawnSupply {};
			class spawnVehicle {};
		};

		class persistence
		{
			class deleteItem {};
			class deleteVehicle {};
			class getPlayerData {};
			class loadEnvironment {};
			class loadItems {};
			class loadLocations {};
			class loadPlayer {};
			class loadTrees {};
			class loadVehicles {};
			class saveEnvironment {};
			class saveItem {};
			class savePlayer {};
			class saveTree {};
			class saveVehicle {};
		};
		
		class players 
		{
			class actionTreeRemoval {};
			class setupPlayerSelf {};
		};

		class sites 
		{
			class prepAA {};
			class prepAmbush {};
			class prepArty {};
			class prepCiv {};
			class prepGarrison {};
			class spawnAA {};
			class spawnAmbush {};
			class spawnArty {};
			class spawnCiv {};
			class spawnGarrison {};
		};

		class WarDirector
		{
			class gridActivate {};
			class gridDeactivate {};
			class gridSetup {};
			class gridLoad {};
			class gridReinforce {};
			class wdTick {};
			class gridspawnForces {};
		};
	};
};