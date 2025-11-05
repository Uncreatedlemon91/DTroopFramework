class CfgFunctions
{
	class Lmn
	{
		class general 
		{
			class addActions {};
			class getNearPlayers {};
			class setupItems {};
			class setupVehicle {};
			class spawnCivilian {};
			class timeManager {};
		};

		class locations 
		{
			class createLocation {};
			class createLocation2 {};
			class getNearLocations {};
			class loadLocations {};
			class saveLocation {};
			class setLocationFaction {};
			class setLocationID {};
			class setupLocations {};
		};

		class logi
		{
			class spawnSupply {};
			class spawnVehicle {};
		};

		class LogiDirector
		{
			class ldSendTroops {};
			class ldAttackSite {};
			class ldTick {};
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
			class addPersonnelActions {};
			class recordDeath {};
			class setupPlayerSelf {};
		};

		class roles
		{
			class addActionToItem {};
			class getPlayerWhitelistedRoles {};
			class getRole {};
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

		class TacticalDirector
		{
			class tdAmbush {};
			class tdAttack {};
			class tdDefend {};
			class tdPatrol {};
			class tdSpawnTroops {};
			class tdTick {}; 
		}
	};
};