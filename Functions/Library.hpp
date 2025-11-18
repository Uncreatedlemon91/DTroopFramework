class CfgFunctions
{
	class Lmn
	{
		class battalions 
		{
			class battalionLogic {};
			class createBattalion {};
			class getGroupDetails {};
			class loadBattalions {};
			class setBattTrigger {};
			class spawnBattalion {};
		};
		class FactionDirector
		{
			class createConvoy {};
			class createHUBsupply {};
			class USdirector {};
		};
		class general 
		{
			class addActions {};
			class attachMarker {};
			class getNearPlayers {};
			class moveTrigger {};
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

		class roles
		{
			class addActionToItem {};
			class getPlayerWhitelistedRoles {};
			class getRole {};
		};
		class squads 
		{
			class squadBuild {};
			class squadGetSupply {};
			class squadPatrol {};
			class squadRecon {};
		}
	};
};