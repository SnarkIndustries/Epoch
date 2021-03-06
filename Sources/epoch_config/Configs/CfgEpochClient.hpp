class CfgEpochClient
{
	epochVersion = "0.3.3.1";

	sapperRngChance = 100; // increase number to reduce chances and reduce to increase. Default 100 = 1% - 55% if soiled (+ 2% if in city) chance to spawn sapper
	droneRngChance = 100; // increase number to reduce chances and reduce to increase. Default 100 = // 2% chance (+ 4% chance if in city) (1% - 2% Half if using silencer) to spawn drone if shot fired

	buildingNearbyMilitary = 0; //1 to allow building nearby
	buildingNearbyMilitaryRange = 300; //Define radius of blocked area

	buildingRequireJammer = 0; // 1 = to allow building without a jammer
	buildingCountLimit = 200; // how many objects can be built within range of a jammer
	buildingJammerRange = 75; // jammer range in meters

	EPOCH_news[] = {"Word is that Sappers have a new boss.","Dogs will often lure them monsters away.","My dog was blown up. I miss him.."};

	antagonistSpawnIndex[] = {
		{"Epoch_Cloak_F", 1}, // {"type", limit}
		{"GreatWhite_F", 2},
		{"Epoch_Sapper_F",2},
		{"Epoch_SapperB_F",1},
		{"I_UAV_01_F",2},
		{"PHANTOM",1},
		{"B_Heli_Transport_01_F",1}
	};

	customVarsDefaults[] = {
		{"Temp",98.6}, // EPOCH_player + varName, default value
		{"Hunger",5000},
		{"Thirst",2500},
		{"AliveTime",0},
		{"Energy",0},
		{"Wet",0},
		{"Soiled",0},
		{"Immunity",0},
		{"Toxicity",0},
		{"Stamina",100},
		{"Crypto",0},
		{"HitPoints",{0,0,0,0}},
		{"BloodP",100},
		{"SpawnArray",{}}
	};

	// controls max group limit and cost
	group_upgrade_lvl[] = {4,"100",6,"300",8,"500",10,"1000",12,"1500",13,"1750",14,"2000",15,"3000",16,"5000"};

	lootClasses[] = {
		{ "shelfPos", "Shelf_EPOCH", true },
		{ "fridgePos", "Fridge_EPOCH", true },
		{ "bedPos", "Bed_EPOCH", false },
		{ "couchPos", "Couch_EPOCH", false },
		{ "wardrobePos", "wardrobe_epoch", false },
		{ "cookerPos", "cooker_epoch", false },
		{ "chairPos", { "Chair_EPOCH", "ChairRed_EPOCH" }, true },
		{ "filingPos", "Filing_epoch", true },
		{ "pelicanPos", "Pelican_EPOCH", false },
		{ "tablePos", "Table_EPOCH", false },
		{ "lockerPos", "Locker_EPOCH", false },
		{ "toolRackPos", "ToolRack_EPOCH", false },
		{ "shoeboxPos", "Shoebox_EPOCH", false },
		{ "palletPos", "Tarp_EPOCH", false },
		{ "freezerPos", "Freezer_EPOCH", false },
		{ "cabinetPos", "Cabinet_EPOCH", false }
	};

	
	#include "CfgEpochClient\takistan.hpp"
	#include "CfgEpochClient\australia.hpp"
	#include "CfgEpochClient\ProvingGrounds_PMC.hpp"
	#include "CfgEpochClient\utes.hpp"
	#include "CfgEpochClient\Sara.hpp"
	#include "CfgEpochClient\Altis.hpp"
	#include "CfgEpochClient\Bornholm.hpp"
	#include "CfgEpochClient\Chernarus_Summer.hpp"
	#include "CfgEpochClient\Chernarus.hpp"
	#include "CfgEpochClient\Stratis.hpp"
	#include "CfgEpochClient\Esseker.hpp"

};

class CfgEpochSapper
{
	detonateDistMax = 8; //Random distance between 3m and this number at which sapper detonates. Min value = 4
	groanTrig = 16; //Percentage chance of a groan. Min value = 4
	sRange = 300; //Distance from target over which sapper will dispose. Range within which sapper code will be aware of targets. Distance up to which sapper will attempt to find a spot to hide in. Min Value = 150.
	smellDist = 24; //Distance up to which sapper can smell. Used to decide if sapper can see target when deciding to charge and influences target selection. Is influenced by wind direction. Min Value = 8.
};

class CfgEpochUAV
{
	UAVMinDist = 48; //Minimum distance to choose next position when roaming. Min Value = 8.
	UAVMaxDist = 180; //Maximum distance to choose next position when roaming. Min Value = 42 / Max Value = 400.
	UAVHeight = 100; //Set height when roaming, slight randomness is applied to this value. UAV will choose own height when locked onto target. Min Value = 42 / Max Value = 280. UAV can still spot targets from height !
};

class CfgEpochAirDrop
{
	AirDropFreq = 1200; //AirDropChance, to decide if Air drop occurs, will only be checked once per AirDropFreq time period, for each player. Min value = 120.
	AirDropChance = 6; //Percentage chance of air drop, for current player. Checked every AirDropFreq and upon antagonists spawn trigger. -1 To disable.
};

class CfgEpochCloak
{
	cRange = 300; //Distance, from target, at which Cloak will dispose. Cloak is also aware of players within this range. (Min: 60 / Max: 600)
	cAggression = 75; //Percentage chance of attack, currently a psychological attack (Cultist spooky voice). (Min: 1 / Max: 100)
	attackFrequency = 120; //One attack only per this period. (Min: 120)
	attackDistance = 38; // Distance, from target, up to which Cloak will attack. Lower for less vocals. (Min: 16)
	targetChangeFrequency = 42; //Cloak will only attempt to change target once per this period. Make Higher to stick to first target player. (Min: 42)
	teleportChance = 66; //Chance for cloak to teleport. (Min: 1)
	hoverFrequency = 1280; //Cloak has new hover attack. When player is above cloak, and at a distance, cloak will float to player and teleport attack. Only perform one of these moves per this period. (Min: 240)
};
