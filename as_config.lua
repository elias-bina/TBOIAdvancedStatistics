AS.DEFAULT_CONFIG = {
	---- GENERAL ----
	
	-- Activate all the extra descriptions on the HUD
	--
	--
	-- For accuracy : (Tears that hit / Tears fired)
	--
	-- For level completion : (Nb of rooms you entered / Nb of room in the level)
	--
	-- For killstreak, roomstreak, timestreak : (Max streak in your game, Average of max streaks of all tracked games)
	--
	-- For hits taken : (intentional hits taken , hits taken per level, average of hits taken per level of all tracked games)
	--
	-- For ennemy killed : (grid entities killed (such as poops, bonfire and TNT) , ennemy killed per level, average of ennemy killed per level of all tracked games)
	--
	--
	-- Default = false
	ADDITIONAL_INFO = false,
	-- The extra infos can be individually disabled
	
	-- Displayed additionnal
	-- Default = All true
	ADDITIONAL_ACCURACY = true, ADDITIONAL_LEVEL_COMPLETION = true, ADDITIONAL_KILLSTREAK = true, ADDITIONAL_ROOMSTREAK = true, ADDITIONAL_TIMESTREAK = true, ADDITIONAL_HITS_TAKEN = true, ADDITIONAL_ENNEMY_KILLED = true, 
	-- Displayed additionnal on timer 
	-- Default = All true
	ADDITIONAL_ACCURACY_ONTIMER = true, ADDITIONAL_LEVEL_COMPLETION_ONTIMER = true, ADDITIONAL_KILLSTREAK_ONTIMER = true, ADDITIONAL_ROOMSTREAK_ONTIMER = true, ADDITIONAL_TIMESTREAK_ONTIMER = true, ADDITIONAL_HITS_TAKEN_ONTIMER = true, ADDITIONAL_ENNEMY_KILLED_ONTIMER = true, 
	
	-- Change language of the mod.
	-- Currently Supported: English = "en" (Default), "en_detailed" 
	--                      French = "fr"  	    
	-- If you want to make a translation, please contact me :)
	
	LANG = "en",
	
	-- Change the size of the text
	-- Advised range : 0.5 - 1.5
	-- Default : 1
	TEXT_SIZE = 1,
	
	
	
	---- DISPLAYED STATS ----
	
	-- Toggle display of accuracy stat
	-- Default = true
	TOGGLE_ACCURACY = true,
	
	-- Toggle display of the level completion stat
	-- Default = false
	TOGGLE_LEVEL_COMPLETION = false,
	
	-- Toggle display of the killstreak
	-- Default = false
	TOGGLE_KILLSTREAK = false,
	
	-- Toggle display of the roomstreak
	-- Default = false
	TOGGLE_ROOMSTREAK = false,
	
	-- Toggle display of the timestreak
	-- Default = false
	TOGGLE_TIMESTREAK = false,
	
	-- Toggle display of number of hits taken
	-- Default = true
	TOGGLE_HITS_TAKEN = true,
	
	-- Toggle display of number of ennemy killed
	-- Default = false
	TOGGLE_ENNEMY_KILLED = false,
	
	
	
	---- DISPLAYED STATS ON TIMER ----
	-- These are the same stats, but on the screen where you see the timer 
	
	-- Toggle display of accuracy stat
	-- Default = false
	TOGGLE_ACCURACY_ONTIMER = false,
	
	-- Toggle display of the level completion stat
	-- Default = true
	TOGGLE_LEVEL_COMPLETION_ONTIMER = true,
	
	-- Toggle display of the killstreak
	-- Default = false
	TOGGLE_KILLSTREAK_ONTIMER = false,
	
	-- Toggle display of the roomstreak
	-- Default = false
	TOGGLE_ROOMSTREAK_ONTIMER = false,
	
	-- Toggle display of the timestreak
	-- Default = false
	TOGGLE_TIMESTREAK_ONTIMER = false,
	
	-- Toggle display of number of hits taken
	-- Default = false
	TOGGLE_HITS_TAKEN_ONTIMER = false,
	
	-- Toggle display of number of ennemy killed
	-- Default = false
	TOGGLE_ENNEMY_KILLED_ONTIMER = false
	
	
}