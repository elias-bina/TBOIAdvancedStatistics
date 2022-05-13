
AS.HUD = {
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
		if AS.HUD.is_toggled then 
			if not AS.timer_shown then
				if AS.HUD.alpha > 1.0 then
						AS.HUD.alpha = 1.0
				end
				
				local render_height = 1
				if AS.CONFIG.TOGGLE_ACCURACY then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY) end
				if AS.CONFIG.TOGGLE_LEVEL_COMPLETION then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION) end
				if AS.CONFIG.TOGGLE_KILLSTREAK then render_height = render_height + renderKillStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK) end
				if AS.CONFIG.TOGGLE_ROOMSTREAK then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK) end
				if AS.CONFIG.TOGGLE_TIMESTREAK then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK) end
				if AS.CONFIG.TOGGLE_HITS_TAKEN then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN) end
				if AS.CONFIG.TOGGLE_ENNEMY_KILLED then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS.HUD.MAX_ALPHA * AS.HUD.alpha, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED) end
				
				if AS.HUD.alpha < 0.0 then
					if AS.HUD.alpha_ontimer < 1.0 then
						AS.HUD.alpha_ontimer = 1.0
					end
					render_height = 36
					if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER) end
					if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER) end
					if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER then render_height = render_height + renderKillStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER) end
					if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER) end
				end
			else
				if AS.HUD.alpha_ontimer < 1.0 then
					AS.HUD.alpha_ontimer = 1.0
				end
				render_height = 36
				if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER then render_height = render_height + renderAccuracyText(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER) end
					if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER then render_height = render_height + renderLevelCompletionText(Vector(240,render_height),  AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER) end
					if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER then render_height = render_height + renderKillStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER then render_height = render_height + renderRoomStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER then render_height = render_height + renderTimeStreak(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER) end
					if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER then render_height = render_height + renderHitsTaken(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER) end
					if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER then render_height = render_height + renderEnnemyKilled(Vector(240,render_height), AS.HUD.MAX_ALPHA_ONTIMER * AS.HUD.alpha_ontimer, AS.CONFIG.ADDITIONAL_INFO and AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER) end
			end
		end
	end

end


function AS:onHUDToggle()
	
	if Input.IsActionPressed(ButtonAction.ACTION_MENUTAB,0) then
		AS.HUD.alpha = -1.2
		AS.HUD.alpha_ontimer = AS.HUD.alpha_ontimer + AS.HUD.ALPHA_ONTIMER_INCREASE
		if AS.HUD.alpha_ontimer > 1/AS.HUD.MAX_ALPHA_ONTIMER then
			AS.HUD.alpha_ontimer = 1/AS.HUD.MAX_ALPHA_ONTIMER 
		end
		if AS.HUD.nb_of_tab_frames > AS.HUD.TIMER_SHOWN_RESET and not AS.HUD.has_reset then
			AS.HUD.has_reset = true
			AS.timer_shown = not AS.timer_shown
			AS.HUD.is_toggled = not AS.HUD.is_toggled -- reverts the state of the HUD
		end
		
		if AS.HUD.nb_of_tab_frames > AS.HUD.HUD_TOGGLE_FRAMES and not AS.HUD.has_toggled then
			AS.HUD.has_toggled = true
			AS.HUD.is_toggled = not AS.HUD.is_toggled
		end
		
		AS.HUD.nb_of_tab_frames = AS.HUD.nb_of_tab_frames + 1
		
	else
		if AS.HUD.nb_of_tab_frames < AS.HUD.TIMER_CHANGING_FRAMES and AS.HUD.nb_of_tab_frames > 0 then
			AS.timer_shown = not AS.timer_shown
		end
		AS.HUD.has_reset = false
		AS.HUD.has_toggled = false
		AS.HUD.nb_of_tab_frames = 0
		AS.HUD.alpha =  AS.HUD.alpha + AS.HUD.ALPHA_INCREASE
		AS.HUD.alpha_ontimer = AS.HUD.alpha_ontimer - AS.HUD.ALPHA_ONTIMER_DECREASE
		
	end


end