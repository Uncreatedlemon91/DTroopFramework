class CfgFunctions
{
	class Lmn
	{
		class general 
		{
			class addActions {};
			class setupItems {};
			class setupVehicle {};
			class timeManager {};
		};

		class locations 
		{
			class createLocation {};
			class loadLocations {};
			class saveLocation {};
			class setupLocations {};
		};

		class logi
		{
			class spawnSupply {};
			class spawnVehicle {};
		};

		class persistence
		{
			class deleteFromDatabase {};
			class getPlayerData {};
			class loadEnvironment {};
			class loadItems {};
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
			class recordDeath {};
			class setupPlayerSelf {};
		};

		class sites 
		{
			class prepAA {};
			class prepAmbush {};
			class prepArty {};
			class prepCiv {};
			class prepGarrison {};
			class prepProbe {};
			class spawnAA {};
			class spawnAmbush {};
			class spawnArty {};
			class spawnCiv {};
			class spawnGarrison {};
			class spawnProbe {};
		};

		class WarDirector
		{
			class tdAmbush {};
			class tdTick {};
			class wdCheckLocs {};
			class wdLogisticsTick {};
			class wdTick {};
			class wdTransfer {};
		};
	};
};