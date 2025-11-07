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
			class getNearLocations {};
			class loadLocations {};
			class saveLocation {};
			class setCivilianCount {};
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
			class loadEnvironment {};
			class loadItems {};
			class loadVehicles {};
			class saveEnvironment {};
			class saveItem {};
			class saveVehicle {};
		};

		class players 
		{
			class addPersonnelActions {};
			class getPlayerData {};
			class loadPlayer {};
			class recordDeath {};
			class savePlayer {};
		};

		class regiments
		{
			class createRegiment {};
			class getRegiment {};
			class loadRegiments {};
			class saveRegiment {};
		};

		class roles
		{
			class addActionToItem {};
			class getPlayerWhitelistedRoles {};
			class getRole {};
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