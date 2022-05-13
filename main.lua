AS = RegisterMod("Advanced Statistics",1)
local game = Game()

AS.Languages = {"en", "en_detailed", "fr"}
AS.text = {} -- Table that holds all translation strings

local RoomConfig = {}
local RoomList = {}
local json = require("json")

require("as_config")
AS.CONFIG = AS.DEFAULT_CONFIG

require("as_mod_config_menu")


--languages
for _,lang in ipairs(AS.Languages) do
	require("as_lang."..lang)
end

-- TODO : Brimstone compatibility

AS.ACCURACY ={
	TOTAL_TEARS = 0,
	HIT_TEARS = 0
}

AS.HIT_STATS ={
	MAX_KILLS_NOHIT = 0,
	AVG_MAX_KILLS_NOHIT = 0,
	WEIGHT_MAX_KILLS_NOHIT = 0,
	
	MOB_KILLED = 0,
	MOB_KILLED_PER_LEVEL = 0,
	AVG_MOB_KILLED_PER_LEVEL = 0,
	WEIGHT_MOB_KILLED_PER_LEVEL = 0,
	
	ENTITIES_KILLED = 0,
	MOB_KILLED_NOHIT = 0,
	BAD_HITS_TAKEN = 0,
	
	BAD_HITS_TAKEN_PER_LEVEL = 0,
	AVG_BAD_HITS_TAKEN_PER_LEVEL = 0,
	WEIGHT_BAD_HITS_TAKEN_PER_LEVEL = 0,
	
	HITS_TAKEN = 0
}

AS.LEVEL = {
	NB_CLEARED_LEVELS = 0,
	NB_CLEARED_ROOMS = 0,
	ROOM_CLEARED_NOHIT = 0,
	
	MAX_ROOM_CLEARED_NOHIT = 0,
	AVG_MAX_ROOM_CLEARED_NOHIT = 0,
	WEIGHT_MAX_ROOM_CLEARED_NOHIT = 0
}

AS.GLOBAL = {
	NB_FRAMES = 0,
	NB_FRAMES_NOHIT = 0,
	MAX_FRAMES_NOHIT = 0,
	AVG_MAX_FRAMES_NOHIT = 0,
	WEIGHT_MAX_FRAMES_NOHIT = 0
	
	
}

AS_HUD = {
	alpha = 1.0,
	ALPHA_INCREASE = 0.007,
	alpha_ontimer = 1.0,
	MAX_ALPHA = 0.6,
	ALPHA_ONTIMER_DECREASE = 0.01,
	ALPHA_ONTIMER_INCREASE = 0.003,
	MAX_ALPHA_ONTIMER = 0.3,
	nb_of_tab_frames = 0,
	nb_of_tab_frames_update = 0,
	timer_shown = false,
	TIMER_CHANGING_FRAMES = 485,
	TIMER_SHOWN_RESET = 14700,
	has_reset = false,
	
	HUD_TOGGLE_FRAMES = (2940 / 2 * 1.5) ,
	is_toggled = true,
	has_toggled = false
	
}


local Font10 = Font()
Font10:Load("font/teammeatfont10.fnt")

local Font12 = Font()
Font12:Load("font/teammeatfont12.fnt")

local Font16Bold = Font()
Font16Bold:Load("font/teammeatfont16bold.fnt")




function AS:onPlayerInit(player)
	local room = game:GetLevel():GetCurrentRoom()
	RoomConfig = {}
	for i = 1, room:GetGridSize() do
		local Grid = room:GetGridEntity(i)
		if Grid == nil then
			RoomConfig[i] = nil
		else
			RoomConfig[i] = {Type = Grid.Desc.Type, Variant = Grid.Desc.Variant, State = Grid.Desc.State}
		end
	end
	
	
	
	
		
	local content = json.decode(AS:LoadData())

	AS.ACCURACY = content.ACCURACY
	AS.HIT_STATS = content.HIT_STATS
	AS.LEVEL = content.LEVEL
	AS.GLOBAL = content.GLOBAL
	
	
	-- ACCURACY
	
	if AS.ACCURACY == nil then AS.ACCURACY = {} end
	if AS.ACCURACY.TOTAL_TEARS == nil then AS.ACCURACY.TOTAL_TEARS = 0 end
	if AS.ACCURACY.HIT_TEARS == nil then AS.ACCURACY.HIT_TEARS = 0 end
	
	-- HIT STATS
	
	if AS.HIT_STATS == nil then AS.HIT_STATS = {} end
	-- Max kill nohit
	if AS.HIT_STATS.MAX_KILLS_NOHIT == nil then AS.HIT_STATS.MAX_KILLS_NOHIT = 0 end
	if AS.HIT_STATS.AVG_MAX_KILLS_NOHIT == nil then AS.HIT_STATS.AVG_MAX_KILLS_NOHIT = 0 end
	if AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT == nil then AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT = 0 end
	
	if AS.HIT_STATS.MOB_KILLED == nil then AS.HIT_STATS.MOB_KILLED = 0 end
	-- Mob killed per level
	if AS.HIT_STATS.MOB_KILLED_PER_LEVEL == nil then AS.HIT_STATS.MOB_KILLED_PER_LEVEL = 0 end
	if AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL == nil then AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL = 0 end
	if AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL == nil then AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL = 0 end
	
	if AS.HIT_STATS.ENTITIES_KILLED == nil then AS.HIT_STATS.ENTITIES_KILLED = 0 end
	if AS.HIT_STATS.MOB_KILLED_NOHIT == nil then AS.HIT_STATS.MOB_KILLED_NOHIT = 0 end
	if AS.HIT_STATS.BAD_HITS_TAKEN == nil then AS.HIT_STATS.BAD_HITS_TAKEN = 0 end
	-- Bad hits taken per level 
	if AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL == nil then AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL = 0 end
	if AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL == nil then AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL = 0 end
	if AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL == nil then AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL = 0 end
	
	if AS.HIT_STATS.HITS_TAKEN == nil then AS.HIT_STATS.HITS_TAKEN = 0 end
	
	-- LEVEL
	
	if AS.LEVEL == nil then AS.LEVEL = {} end
	if AS.LEVEL.NB_CLEARED_LEVELS == nil then  AS.LEVEL.NB_CLEARED_LEVELS = 0 end
	if AS.LEVEL.NB_CLEARED_ROOMS == nil then  AS.LEVEL.NB_CLEARED_ROOMS = 0 end
	if AS.LEVEL.ROOM_CLEARED_NOHIT == nil then  AS.LEVEL.ROOM_CLEARED_NOHIT = 0 end
	-- Max room nohit
	if AS.LEVEL.MAX_ROOM_CLEARED_NOHIT == nil then  AS.LEVEL.MAX_ROOM_CLEARED_NOHIT = 0 end
	if AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT == nil then  AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT = 0 end
	if AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT == nil then  AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT = 0 end
	
	-- GLOBAL
	
	if AS.GLOBAL == nil then AS.GLOBAL = {} end
	if AS.GLOBAL.NB_FRAMES == nil then  AS.GLOBAL.NB_FRAMES = 0 end
	if AS.GLOBAL.NB_FRAMES_NOHIT == nil then  AS.GLOBAL.NB_FRAMES_NOHIT = 0 end
	-- Max frames nohit
	if AS.GLOBAL.MAX_FRAMES_NOHIT == nil then  AS.GLOBAL.MAX_FRAMES_NOHIT = 0 end
	if AS.GLOBAL.AVG_MAX_FRAMES_NOHIT == nil then  AS.GLOBAL.AVG_MAX_FRAMES_NOHIT = 0 end
	if AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT == nil then  AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT = 0 end
		
	
	if AS.MCMLoaded then 
		AS.CONFIG = content.CONFIG
		if AS.CONFIG == nil then AS.CONFIG = AS.DEFAULT_CONFIG end
		
		
		if AS.CONFIG.ADDITIONAL_INFO == nil then AS.CONFIG.ADDITIONAL_INFO = AS.DEFAULT_CONFIG.ADDITIONAL_INFO end
		if AS.CONFIG.TEXT_SIZE == nil then AS.CONFIG.TEXT_SIZE = AS.DEFAULT_CONFIG.TEXT_SIZE end
		
		-- Load config of additional print of stats on the base HUD if it wasn't saved
		if AS.CONFIG.ADDITIONAL_ACCURACY == nil then AS.CONFIG.ADDITIONAL_ACCURACY = AS.DEFAULT_CONFIG.ADDITIONAL_ACCURACY end
		if AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION == nil then AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION  = AS.DEFAULT_CONFIG.ADDITIONAL_LEVEL_COMPLETION end
		if AS.CONFIG.ADDITIONAL_KILLSTREAK == nil then AS.CONFIG.ADDITIONAL_KILLSTREAK = AS.DEFAULT_CONFIG.ADDITIONAL_KILLSTREAK end
		if AS.CONFIG.ADDITIONAL_ROOMSTREAK == nil then AS.CONFIG.ADDITIONAL_ROOMSTREAK = AS.DEFAULT_CONFIG.ADDITIONAL_ROOMSTREAK end
		if AS.CONFIG.ADDITIONAL_TIMESTREAK == nil then AS.CONFIG.ADDITIONAL_TIMESTREAK = AS.DEFAULT_CONFIG.ADDITIONAL_TIMESTREAK end
		if AS.CONFIG.ADDITIONAL_HITS_TAKEN == nil then AS.CONFIG.ADDITIONAL_HITS_TAKEN = AS.DEFAULT_CONFIG.ADDITIONAL_HITS_TAKEN end
		if AS.CONFIG.ADDITIONAL_ENNEMY_KILLED == nil then AS.CONFIG.ADDITIONAL_ENNEMY_KILLED  = AS.DEFAULT_CONFIG.ADDITIONAL_ENNEMY_KILLED end
		
		-- Load config of additional print of stats on timer if it wasn't saved
		if AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER == nil then AS.CONFIG.ADDITIONAL_ACCURACY  = AS.DEFAULT_CONFIG.ADDITIONAL_ACCURACY end
		if AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER == nil then AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER end
		if AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER == nil then AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER end
		if AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER == nil then AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER end
		if AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER == nil then AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER end
		if AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER == nil then AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER end
		if AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER == nil then AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER  = AS.DEFAULT_CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER end
		
		if AS.CONFIG.LANG == nil then AS.CONFIG = AS.DEFAULT_CONFIG.LANG end
		
		-- Load config of stats toggled on the base HUD if it wasn't saved
		if AS.CONFIG.TOGGLE_ACCURACY == nil then AS.CONFIG.TOGGLE_ACCURACY  = AS.DEFAULT_CONFIG.TOGGLE_ACCURACY end
		if AS.CONFIG.TOGGLE_LEVEL_COMPLETION == nil then AS.CONFIG.TOGGLE_LEVEL_COMPLETION  = AS.DEFAULT_CONFIG.TOGGLE_LEVEL_COMPLETION end
		if AS.CONFIG.TOGGLE_KILLSTREAK == nil then AS.CONFIG.TOGGLE_KILLSTREAK  = AS.DEFAULT_CONFIG.TOGGLE_KILLSTREAK end
		if AS.CONFIG.TOGGLE_ROOMSTREAK == nil then AS.CONFIG.TOGGLE_ROOMSTREAK  = AS.DEFAULT_CONFIG.TOGGLE_ROOMSTREAK end
		if AS.CONFIG.TOGGLE_TIMESTREAK == nil then AS.CONFIG.TOGGLE_TIMESTREAK  = AS.DEFAULT_CONFIG.TOGGLE_TIMESTREAK end
		if AS.CONFIG.TOGGLE_HITS_TAKEN == nil then AS.CONFIG.TOGGLE_HITS_TAKEN  = AS.DEFAULT_CONFIG.TOGGLE_HITS_TAKEN end
		if AS.CONFIG.TOGGLE_ENNEMY_KILLED == nil then AS.CONFIG.TOGGLE_ENNEMY_KILLED  = AS.DEFAULT_CONFIG.TOGGLE_ENNEMY_KILLED end
		
		-- Load config of stats toggled on timer if it wasn't saved
		if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER == nil then AS.CONFIG.TOGGLE_ACCURACY_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_ACCURACY_ONTIMER end
		if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER == nil then AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER = AS.DEFAULT_CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER end
		if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER == nil then AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_KILLSTREAK_ONTIMER end
		if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER == nil then AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_ROOMSTREAK_ONTIMER end
		if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER == nil then AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_TIMESTREAK_ONTIMER end
		if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER == nil then AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_HITS_TAKEN_ONTIMER end
		if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER == nil then AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER  = AS.DEFAULT_CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER end
	end	
		
		
		
	if game:GetFrameCount() == 0 then
		AS.ACCURACY.TOTAL_TEARS = 0
		AS.ACCURACY.HIT_TEARS = 0
		
		AS.HIT_STATS.MAX_KILLS_NOHIT = 0
		AS.HIT_STATS.MOB_KILLED = 0
		AS.HIT_STATS.ENTITIES_KILLED = 0
		AS.HIT_STATS.MOB_KILLED_NOHIT = 0
		AS.HIT_STATS.BAD_HITS_TAKEN = 0
		AS.HIT_STATS.HITS_TAKEN = 0
		
		AS.LEVEL.NB_CLEARED_LEVELS = 0
		AS.LEVEL.NB_CLEARED_ROOMS = 0
		AS.LEVEL.ROOM_CLEARED_NOHIT = 0
		AS.LEVEL.MAX_ROOM_CLEARED_NOHIT = 0
		
		AS.GLOBAL.MAX_FRAMES = 0
		AS.GLOBAL.MAX_FRAMES_NOHIT = 0
		AS.GLOBAL.NB_FRAMES_NOHIT = 0
	end
	
	AS_HUD.alpha = 1.0
	AS_HUD.nb_of_tab_frames = 0
	AS_HUD.timer_shown = false
end

AS:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, AS.onPlayerInit)

local function saveGame()
	local content = {
		ACCURACY = AS.ACCURACY,
		HIT_STATS = AS.HIT_STATS,
		LEVEL = AS.LEVEL,
		GLOBAL = AS.GLOBAL,
		
	}
	
	if AS.MCMLoaded then 
		content.CONFIG = AS.CONFIG
	end
	
	AS:SaveData(json.encode(content))
end




function AS:onGameExit(shouldSave)

	if not shouldSave then -- end of a run so we actually save the stats x)
		local run_weight = (AS.LEVEL.NB_CLEARED_LEVELS - 1)  + AS.LEVEL.NB_CLEARED_ROOMS / game:GetLevel():GetRoomCount() -- The weight of the run in the average stats
		-- Isaac.ConsoleOutput(AS.LEVEL.NB_CLEARED_LEVELS .." PD " ..run_weight .. "\n")
		
		-- Update max kills no hit
		local total_avg =  AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT * AS.HIT_STATS.AVG_MAX_KILLS_NOHIT + run_weight * AS.HIT_STATS.MAX_KILLS_NOHIT
		AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT = AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT + run_weight
		AS.HIT_STATS.AVG_MAX_KILLS_NOHIT = total_avg / AS.HIT_STATS.WEIGHT_MAX_KILLS_NOHIT
		
		-- Update max room no hit
		total_avg =  AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT * AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT + run_weight * AS.LEVEL.MAX_ROOM_CLEARED_NOHIT
		AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT = AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT + run_weight
		AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT = total_avg / AS.LEVEL.WEIGHT_MAX_ROOM_CLEARED_NOHIT
		
		-- Update frames no hit
		total_avg =  AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT * AS.GLOBAL.AVG_MAX_FRAMES_NOHIT + run_weight * AS.GLOBAL.MAX_FRAMES_NOHIT
		AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT = AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT + run_weight
		AS.GLOBAL.AVG_MAX_FRAMES_NOHIT = total_avg / AS.GLOBAL.WEIGHT_MAX_FRAMES_NOHIT
		
		-- Update bad hits taken per level
		total_avg =  AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL * AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL + run_weight * AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL
		AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL = AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL + run_weight
		AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL = total_avg / AS.HIT_STATS.WEIGHT_BAD_HITS_TAKEN_PER_LEVEL
		
		-- Update mob killed per level
		total_avg =  AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL * AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL + run_weight * AS.HIT_STATS.MOB_KILLED_PER_LEVEL
		AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL = AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL + run_weight
		AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL = total_avg / AS.HIT_STATS.WEIGHT_MOB_KILLED_PER_LEVEL
		
		
	end


	saveGame()
end

AS:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, AS.onGameExit)




 

function AS:onGameOver(mort_lol)
	-- AS.ACCURACY.TOTAL_TEARS = 0
	-- AS.ACCURACY.HIT_TEARS = 0
	
	-- AS.HIT_STATS.MAX_KILLS_NOHIT = 0
	-- AS.HIT_STATS.MOB_KILLED = 0
	-- AS.HIT_STATS.MOB_KILLED_PER_LEVEL = 0
	-- AS.HIT_STATS.ENTITIES_KILLED = 0
	-- AS.HIT_STATS.MOB_KILLED_NOHIT = 0
	-- AS.HIT_STATS.BAD_HITS_TAKEN = 0
	-- AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL = 0
	-- AS.HIT_STATS.HITS_TAKEN = 0
	
	-- AS.LEVEL.NB_CLEARED_LEVELS = 0
	-- AS.LEVEL.NB_CLEARED_ROOMS = 0
	-- AS.LEVEL.ROOM_CLEARED_NOHIT = 0
	-- AS.LEVEL.MAX_ROOM_CLEARED_NOHIT = 0
	
	-- AS.GLOBAL.NB_FRAMES = 0
	-- AS.GLOBAL.MAX_FRAMES_NOHIT = 0
	-- AS.GLOBAL.NB_FRAMES_NOHIT = 0
	
	saveGame()
end

AS:AddCallback(ModCallbacks.MC_POST_GAME_END, AS.onGameOver)


function AS:onNewRoom()
	-- Sets the roomConfig
	local room = game:GetLevel():GetCurrentRoom()
	RoomConfig = {}
	for i = 1, room:GetGridSize() do
		local Grid = room:GetGridEntity(i)
		if Grid == nil then
			RoomConfig[i] = nil
		else
			RoomConfig[i] = {Type = Grid.Desc.Type, Variant = Grid.Desc.Variant, State = Grid.Desc.State}
		end
	end
end

AS:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AS.onNewRoom)



function AS:onNewLevel()
	AS.LEVEL.NB_CLEARED_ROOMS = 1
	AS.LEVEL.NB_CLEARED_LEVELS = AS.LEVEL.NB_CLEARED_LEVELS + 1
	AS.HIT_STATS.MOB_KILLED_PER_LEVEL = AS.HIT_STATS.MOB_KILLED / AS.LEVEL.NB_CLEARED_LEVELS
	AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL = AS.HIT_STATS.BAD_HITS_TAKEN / AS.LEVEL.NB_CLEARED_LEVELS
	-- Isaac.ConsoleOutput("Stage : " .. game:GetLevel():GetStage() .. "\n")
end

AS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, AS.onNewLevel)



function AS:onUpdate(player)
	local room = game:GetLevel():GetCurrentRoom()
	
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Type == EntityType.ENTITY_FIREPLACE and entity.HitPoints == 1.0 and not entity:GetData().Died then
			entity:GetData().Died = true
			AS.HIT_STATS.ENTITIES_KILLED = AS.HIT_STATS.ENTITIES_KILLED + 1
		end
	end 
	
	
	--Checks if the grid changed
	for i = 1, room:GetGridSize() do
		local Grid = room:GetGridEntity(i)
		if Grid and RoomConfig[i] and
			(Grid.Desc.Type ~= RoomConfig[i].Type or
			 Grid.Desc.Variant ~= RoomConfig[i].Variant or
			 Grid.Desc.State ~= RoomConfig[i].State )then
			-- Isaac.ConsoleOutput(RoomConfig[i].Type)
			if Grid.Desc.Type == GridEntityType.GRID_POOP or RoomConfig[i].Type == GridEntityType.GRID_TNT then
				AS.ACCURACY.HIT_TEARS = AS.ACCURACY.HIT_TEARS + 1
				
				-- Isaac.ConsoleOutput(Grid.Desc.State .."\n")
				if (Grid.Desc.Type == GridEntityType.GRID_POOP and Grid.Desc.State == 1000) or (RoomConfig[i].Type == GridEntityType.GRID_TNT and Grid.Desc.State == 4)  then
					AS.HIT_STATS.ENTITIES_KILLED = AS.HIT_STATS.ENTITIES_KILLED + 1
				end
			end
		end
		if Grid then
			RoomConfig[i] = {Type = Grid.Desc.Type, Variant = Grid.Desc.Variant, State = Grid.Desc.State}
		end
	end
	AS.GLOBAL.NB_FRAMES = AS.GLOBAL.NB_FRAMES + 1
	AS.GLOBAL.NB_FRAMES_NOHIT = AS.GLOBAL.NB_FRAMES_NOHIT + 1
end

AS:AddCallback(ModCallbacks.MC_POST_UPDATE, AS.onUpdate)




function AS:onTearCollision(Tear, Collider, low)
	if Tear.StickTarget == nil then
		AS.ACCURACY.HIT_TEARS = AS.ACCURACY.HIT_TEARS + 1
	end
end

AS:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, AS.onTearCollision)




function AS:onTearDeath(Tear)
	
	AS.ACCURACY.TOTAL_TEARS = AS.ACCURACY.TOTAL_TEARS + 1

end

AS:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE , AS.onTearDeath, EntityType.ENTITY_TEAR)


function AS:onEnemyDeath(entity)
	if entity:IsEnemy() then
		if entity.Type == EntityType.ENTITY_MOVABLE_TNT then
			AS.HIT_STATS.ENTITIES_KILLED = AS.HIT_STATS.ENTITIES_KILLED + 1
		else
			AS.HIT_STATS.MOB_KILLED = AS.HIT_STATS.MOB_KILLED + 1
			AS.HIT_STATS.MOB_KILLED_PER_LEVEL = AS.HIT_STATS.MOB_KILLED / AS.LEVEL.NB_CLEARED_LEVELS
			AS.HIT_STATS.MOB_KILLED_NOHIT = AS.HIT_STATS.MOB_KILLED_NOHIT + 1
		end
	end

end

AS:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL , AS.onEnemyDeath)

function AS:onPlayerTakeDamage(TookDamage, DamageAmount, DamageFlags, DamageSource, DamageCountdownFrames)

	AS.HIT_STATS.HITS_TAKEN= AS.HIT_STATS.HITS_TAKEN + 1
	-- Isaac.ConsoleOutput(DamageFlags)
	-- Isaac.ConsoleOutput(DamageFlags & (DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_CURSED_DOOR | DamageFlag.DAMAGE_IV_BAG | DamageFlag.DAMAGE_FAKE))
	if DamageFlags & (DamageFlag.DAMAGE_RED_HEARTS | DamageFlag.DAMAGE_NO_PENALTIES | DamageFlag.DAMAGE_CURSED_DOOR | DamageFlag.DAMAGE_IV_BAG | DamageFlag.DAMAGE_FAKE) == 0 then
		AS.HIT_STATS.BAD_HITS_TAKEN= AS.HIT_STATS.BAD_HITS_TAKEN + 1
		AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL = AS.HIT_STATS.BAD_HITS_TAKEN / AS.LEVEL.NB_CLEARED_LEVELS
		AS.HIT_STATS.MOB_KILLED_NOHIT = 0
		AS.LEVEL.ROOM_CLEARED_NOHIT = 0
		AS.GLOBAL.NB_FRAMES_NOHIT = 0
	end
	
end

AS:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, AS.onPlayerTakeDamage, EntityType.ENTITY_PLAYER)



function AS:onNewRoom()
	if game:GetRoom():IsFirstVisit() then
		AS.LEVEL.NB_CLEARED_ROOMS = AS.LEVEL.NB_CLEARED_ROOMS + 1 
		AS.LEVEL.ROOM_CLEARED_NOHIT = AS.LEVEL.ROOM_CLEARED_NOHIT + 1
	end
end

AS:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, AS.onNewRoom)


local function colorGradient(percentage)
	if percentage < 0 then percentage = 0 end
	if percentage > 1 then percentage = 1 end
	
	local color = {
		R = (1 - percentage)*4/3,
		G = percentage*4/3,
		B = 0
	}
	return color
end

local function renderAccuracyText(pos, alpha, more_info)
	local accuracy = 1
	if AS.ACCURACY.TOTAL_TEARS ~= 0 then
		accuracy = AS.ACCURACY.HIT_TEARS/AS.ACCURACY.TOTAL_TEARS
	end
	
	local chaine = AS.text[AS.CONFIG.LANG].accuracy .." : " .. math.floor(accuracy*100) .. "%"
	
	if more_info then
		chaine = chaine .." (" .. AS.text[AS.CONFIG.LANG].accuracy_hit_tears .. AS.ACCURACY.HIT_TEARS .. "/" .. AS.text[AS.CONFIG.LANG].accuracy_total_tears .. AS.ACCURACY.TOTAL_TEARS .. ")"
	end
	
	
	-- inital range : 0 , 1
	-- final range : -1 , 2
	local color = colorGradient(accuracy*3 - 1)
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

 local function renderLevelCompletionText(pos, alpha, more_info)
	
	local completion =  AS.LEVEL.NB_CLEARED_ROOMS / game:GetLevel():GetRoomCount() 
	
	local chaine = AS.text[AS.CONFIG.LANG].level_completion .." : " .. math.floor(completion*100) .. "%"
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].level_completion_cleared_room .. AS.LEVEL.NB_CLEARED_ROOMS .. "/" .. AS.text[AS.CONFIG.LANG].level_completion_total_room .. game:GetLevel():GetRoomCount() .. ")"
	end
	
	local color = colorGradient(completion*3 - 1)
	-- Isaac.RenderText(chaine, pos.X - Isaac.GetTextWidth(chaine)/2, pos.Y, color.R, color.G, color.B, alpha)
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

local function renderKillStreak(pos, alpha, more_info)
	
	if AS.HIT_STATS.MOB_KILLED_NOHIT > AS.HIT_STATS.MAX_KILLS_NOHIT then
		AS.HIT_STATS.MAX_KILLS_NOHIT = AS.HIT_STATS.MOB_KILLED_NOHIT
	end
	
	local chaine = AS.text[AS.CONFIG.LANG].killstreak .. " : " .. AS.HIT_STATS.MOB_KILLED_NOHIT
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].maximum .. " : " .. AS.HIT_STATS.MAX_KILLS_NOHIT .. ", " .. AS.text[AS.CONFIG.LANG].max_avg .. string.format(" : %.2f)", AS.HIT_STATS.AVG_MAX_KILLS_NOHIT)
	end
	
	
	local color = colorGradient(1)
	
	if AS.HIT_STATS.AVG_MAX_KILLS_NOHIT > 0 then
		color = colorGradient( AS.HIT_STATS.MOB_KILLED_NOHIT / AS.HIT_STATS.AVG_MAX_KILLS_NOHIT )
	end
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

local function renderRoomStreak(pos, alpha, more_info)
	
	if AS.LEVEL.ROOM_CLEARED_NOHIT > AS.LEVEL.MAX_ROOM_CLEARED_NOHIT then
		AS.LEVEL.MAX_ROOM_CLEARED_NOHIT = AS.LEVEL.ROOM_CLEARED_NOHIT
	end
	
	local chaine = AS.text[AS.CONFIG.LANG].roomstreak .. " : " .. AS.LEVEL.ROOM_CLEARED_NOHIT
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].maximum .. " : " .. AS.LEVEL.MAX_ROOM_CLEARED_NOHIT .. ", " .. AS.text[AS.CONFIG.LANG].max_avg .. string.format(" : %.2f)", AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT)
	end
	
	local color = colorGradient(1)
	
	if AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT > 0 then
		color = colorGradient( AS.LEVEL.ROOM_CLEARED_NOHIT / AS.LEVEL.AVG_MAX_ROOM_CLEARED_NOHIT )
	end
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

local function framesToTimeStr(frames)
	local time_str = ""
	
	local seconds = frames//30
	local minutes = seconds//60
	local hours = minutes//60
	seconds = seconds%60
	if minutes == 0 then
		time_str = string.format("%ds", seconds)
	else
		minutes = minutes%60
		if hours == 0 then
			time_str = string.format("%dm:%ds", minutes, seconds)
		else
			
			time_str = string.format("%dh:%dm:%ds", hours, minutes, seconds)
		end
	end
	
	
	return time_str
end

local function renderTimeStreak(pos, alpha, more_info)
	
	if AS.GLOBAL.NB_FRAMES_NOHIT > AS.GLOBAL.MAX_FRAMES_NOHIT then
		AS.GLOBAL.MAX_FRAMES_NOHIT = AS.GLOBAL.NB_FRAMES_NOHIT
	end
	
	local chaine = AS.text[AS.CONFIG.LANG].timestreak .. " : " .. framesToTimeStr(AS.GLOBAL.NB_FRAMES_NOHIT)
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].maximum .. " : " .. framesToTimeStr(AS.GLOBAL.MAX_FRAMES_NOHIT) .. ", ".. AS.text[AS.CONFIG.LANG].max_avg .. " : " .. framesToTimeStr(AS.GLOBAL.AVG_MAX_FRAMES_NOHIT) ..")"
	end
	
	local color = colorGradient(1)
	
	if AS.GLOBAL.AVG_MAX_FRAMES_NOHIT > 0 then
		color = colorGradient( AS.GLOBAL.NB_FRAMES_NOHIT / AS.GLOBAL.AVG_MAX_FRAMES_NOHIT )
	end
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

local function renderHitsTaken(pos, alpha, more_info)
	
	local chaine = AS.text[AS.CONFIG.LANG].hits_taken .. ": " .. AS.HIT_STATS.BAD_HITS_TAKEN
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].intentional_hits .. " : ".. (AS.HIT_STATS.HITS_TAKEN - AS.HIT_STATS.BAD_HITS_TAKEN).. "," .. AS.text[AS.CONFIG.LANG].per_level .. string.format(" : %.2f,", AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL).. AS.text[AS.CONFIG.LANG].avg_per_level .. string.format(" : %.2f)" , AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL)
	end
	
	
	local color = colorGradient(1)
	if AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL ~= 0.0 then
		color = colorGradient(1 - ((AS.HIT_STATS.BAD_HITS_TAKEN_PER_LEVEL - (AS.HIT_STATS.AVG_BAD_HITS_TAKEN_PER_LEVEL*3/4))/2))
	end
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end

local function renderEnnemyKilled(pos, alpha, more_info)
	
	local chaine = AS.text[AS.CONFIG.LANG].ennemy_killed .. ": " .. AS.HIT_STATS.MOB_KILLED
	
	if more_info then
		chaine = chaine .. " (" .. AS.text[AS.CONFIG.LANG].grid_entities .. " : " .. AS.HIT_STATS.ENTITIES_KILLED .. "," ..  AS.text[AS.CONFIG.LANG].per_level .. string.format(" : %.2f,",AS.HIT_STATS.MOB_KILLED_PER_LEVEL) .. AS.text[AS.CONFIG.LANG].avg_per_level .. string.format(" : %.2f)", AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL)
	end
	
	local color = colorGradient(1)
	
	if AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL > 0 then
		color = colorGradient(AS.HIT_STATS.MOB_KILLED_PER_LEVEL / AS.HIT_STATS.AVG_MOB_KILLED_PER_LEVEL )
	end
	
	Font10:DrawStringScaled(chaine, pos.X - (Font10:GetStringWidth(chaine)* AS.CONFIG.TEXT_SIZE)/2, pos.Y,AS.CONFIG.TEXT_SIZE,AS.CONFIG.TEXT_SIZE,KColor(color.R, color.G, color.B, alpha,0,0,0),0,false)
	return Font10:GetLineHeight()*AS.CONFIG.TEXT_SIZE
end


function AS:onRender()

	
	--Isaac.ConsoleOutput(AS.timer_shown)
	if game:GetHUD():IsVisible() then
		if AS_HUD.is_toggled then 
			if not AS.timer_shown then
				if AS_HUD.alpha > 1.0 then
						AS_HUD.alpha = 1.0
				end
				
				local render_height = 1
				if AS.CONFIG.TOGGLE_ACCURACY then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY) end
				if AS.CONFIG.TOGGLE_LEVEL_COMPLETION then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION) end
				if AS.CONFIG.TOGGLE_KILLSTREAK then render_height = render_height + renderKillStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK) end
				if AS.CONFIG.TOGGLE_ROOMSTREAK then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK) end
				if AS.CONFIG.TOGGLE_TIMESTREAK then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK) end
				if AS.CONFIG.TOGGLE_HITS_TAKEN then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN) end
				if AS.CONFIG.TOGGLE_ENNEMY_KILLED then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS_HUD.MAX_ALPHA * AS_HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED) end
				
				if AS_HUD.alpha < 0.0 then
					if AS_HUD.alpha_ontimer < 1.0 then
						AS_HUD.alpha_ontimer = 1.0
					end
					render_height = 36
					if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER) end
					if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER) end
					if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER then render_height = render_height + renderKillStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER) end
					if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER) end
				end
			else
				if AS_HUD.alpha_ontimer < 1.0 then
					AS_HUD.alpha_ontimer = 1.0
				end
				render_height = 36
				if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER) end
					if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER) end
					if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER then render_height = render_height + renderKillStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER) end
					if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS_HUD.MAX_ALPHA_ONTIMER * AS_HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER) end
			end
		end
	end

end

AS:AddCallback(ModCallbacks.MC_POST_RENDER, AS.onRender)

function AS:onInput()
	
	if Input.IsActionPressed(ButtonAction.ACTION_MENUTAB,0) then
		AS_HUD.alpha = -1.2
		AS_HUD.alpha_ontimer = AS_HUD.alpha_ontimer + AS_HUD.ALPHA_ONTIMER_INCREASE
		if AS_HUD.alpha_ontimer > 1/AS_HUD.MAX_ALPHA_ONTIMER then
			AS_HUD.alpha_ontimer = 1/AS_HUD.MAX_ALPHA_ONTIMER 
		end
		if AS_HUD.nb_of_tab_frames > AS_HUD.TIMER_SHOWN_RESET and not AS_HUD.has_reset then
			AS_HUD.has_reset = true
			AS.timer_shown = not AS.timer_shown
			AS_HUD.is_toggled = not AS_HUD.is_toggled -- reverts the state of the HUD
		end
		
		if AS_HUD.nb_of_tab_frames > AS_HUD.HUD_TOGGLE_FRAMES and not AS_HUD.has_toggled then
			AS_HUD.has_toggled = true
			AS_HUD.is_toggled = not AS_HUD.is_toggled
		end
		
		AS_HUD.nb_of_tab_frames = AS_HUD.nb_of_tab_frames + 1
		
	else
		if AS_HUD.nb_of_tab_frames < AS_HUD.TIMER_CHANGING_FRAMES and AS_HUD.nb_of_tab_frames > 0 then
			AS.timer_shown = not AS.timer_shown
		end
		AS_HUD.has_reset = false
		AS_HUD.has_toggled = false
		AS_HUD.nb_of_tab_frames = 0
		AS_HUD.alpha =  AS_HUD.alpha + AS_HUD.ALPHA_INCREASE
		AS_HUD.alpha_ontimer = AS_HUD.alpha_ontimer - AS_HUD.ALPHA_ONTIMER_DECREASE
		
	end


end

AS:AddCallback(ModCallbacks.MC_INPUT_ACTION, AS.onInput)


return AS