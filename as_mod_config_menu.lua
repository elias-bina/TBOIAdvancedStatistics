

-- MOD CONFIG MENU Compatibility
local MCMLoaded, MCM = pcall(require, "scripts.modconfig")
AS.MCMLoaded = MCMLoaded



if MCMLoaded then
	function AnIndexOf(t, val)
		for k, v in ipairs(t) do
			if v == val then
				return k
			end
		end
		return 1
	end
	
	---------------------------------------------------------------------------
	-----------------------------------Info------------------------------------
	MCM.AddSpace("Advanced Stats", "Info")
	MCM.AddText("Advanced Stats", "Info", function() return "Advanced Statistics" end)
	MCM.AddSpace("Advanced Stats", "Info")
	MCM.AddText("Advanced Stats", "Info", function() return "by HeliOS" end)
	
	---------------------------------------------------------------------------
	---------------------------------General-----------------------------------
	-- Language
	
	local displayLanguage = {"English", "English (detailed)", "French"}
	MCM.AddSetting(
		"Advanced Stats",
		"General",
		{
			Type = ModConfigMenu.OptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(AS.Languages, AS.CONFIG.LANG)
			end,
			Minimum = 1,
			Maximum = #(AS.Languages),
			Display = function()
				return "Language: " .. displayLanguage[AnIndexOf(AS.Languages, AS.CONFIG.LANG)]
			end,
			OnChange = function(currentNum)
				AS.CONFIG.LANG = AS.Languages[currentNum]
			end,
			Info = {"Changes the language."}
		}
	)

	
	-- Additional info
	MCM.AddSetting(
		"Advanced Stats",
		"General",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_INFO
			end,
			Display = function()
				local onOff = "False"
				if AS.CONFIG.ADDITIONAL_INFO then
					onOff = "True"
				end
				return 'Additional info : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_INFO = currentBool
			end,
			Info = {"Add some extra informations about","the statistic shown in parenthesis"}
		}
	)
	
	-- Text size
	local sizes = {0.5, 0.625, 0.75, 0.875, 1, 1.125, 1.25, 1.375, 1.5}
	MCM.AddSetting(
		"Advanced Stats",
		"General",
		{
			Type = ModConfigMenu.OptionType.SCROLL,
			CurrentSetting = function()
				return AnIndexOf(sizes, AS.CONFIG.TEXT_SIZE) - 1
			end,
			Display = function()
				return "Text Size: $scroll" ..
					AnIndexOf(sizes, AS.CONFIG.TEXT_SIZE) - 1 .. " Scale :" .. AS.CONFIG.TEXT_SIZE .. " "
			end,
			OnChange = function(currentNum)
				AS.CONFIG.TEXT_SIZE = sizes[currentNum + 1]
			end,
			Info = {"Size of the HUD Text (default: 1)"}
		}
	)
	
	
	---------------------------------------------------------------------------
	-----------------------------Displayed stats-------------------------------
								 
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ACCURACY
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ACCURACY then
					onOff = "Yes"
				end
				return 'Show Accuracy : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ACCURACY = currentBool
			end,
			Info = {"Show information about accuracy in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_LEVEL_COMPLETION
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_LEVEL_COMPLETION then
					onOff = "Yes"
				end
				return 'Show Level Completion : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_LEVEL_COMPLETION = currentBool
			end,
			Info = {"Show information about","level completion in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_KILLSTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_KILLSTREAK then
					onOff = "Yes"
				end
				return 'Show KillStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_KILLSTREAK = currentBool
			end,
			Info = {"Show information about mob killed","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ROOMSTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ROOMSTREAK then
					onOff = "Yes"
				end
				return 'Show RoomStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ROOMSTREAK = currentBool
			end,
			Info = {"Show information about rooms entered","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_TIMESTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_TIMESTREAK then
					onOff = "Yes"
				end
				return 'Show TimeStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_TIMESTREAK = currentBool
			end,
			Info = {"Show information about time spend","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_HITS_TAKEN
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_HITS_TAKEN then
					onOff = "Yes"
				end
				return 'Show Hits Taken : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_HITS_TAKEN = currentBool
			end,
			Info = {"Show information about hits taken in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ENNEMY_KILLED
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ENNEMY_KILLED then
					onOff = "Yes"
				end
				return 'Show Ennemy Killed : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ENNEMY_KILLED = currentBool
			end,
			Info = {"Show information about ennemy killed in the HUD"}
		}
	)
	
	
	MCM.AddSpace("Advanced Stats", "Displayed")
	MCM.AddText("Advanced Stats", "Displayed", function() return "Extra info individual toggle" end)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ACCURACY
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ACCURACY then
					onOff = "Yes"
				end
				return 'Extra info on accuracy : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ACCURACY = currentBool
			end,
			Info = {"Show extra information about accuracy in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION then
					onOff = "Yes"
				end
				return 'Extra info on Level Completion : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION = currentBool
			end,
			Info = {"Show extra information about","level completion in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_KILLSTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_KILLSTREAK then
					onOff = "Yes"
				end
				return 'Extra info on KillStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_KILLSTREAK = currentBool
			end,
			Info = {"Show extra information about mob killed","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ROOMSTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ROOMSTREAK then
					onOff = "Yes"
				end
				return 'Extra info on RoomStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ROOMSTREAK = currentBool
			end,
			Info = {"Show extra information about rooms entered","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_TIMESTREAK
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_TIMESTREAK then
					onOff = "Yes"
				end
				return 'Extra info on TimeStreak : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_TIMESTREAK = currentBool
			end,
			Info = {"Show extra information about time spend","without being hit in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_HITS_TAKEN
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_HITS_TAKEN then
					onOff = "Yes"
				end
				return 'Extra info on Hits Taken : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_HITS_TAKEN = currentBool
			end,
			Info = {"Show extra information about hits taken in the HUD"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"Displayed",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ENNEMY_KILLED
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ENNEMY_KILLED then
					onOff = "Yes"
				end
				return 'Extra info on Ennemy Killed : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ENNEMY_KILLED = currentBool
			end,
			Info = {"Show information about ennemy killed in the HUD"}
		}
	)
	
	---------------------------------------------------------------------------
	------------------------------OnTimer stats--------------------------------

	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ACCURACY_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ACCURACY_ONTIMER then
					onOff = "Yes"
				end
				return 'Show Accuracy on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ACCURACY_ONTIMER = currentBool
			end,
			Info = {"Show information about accuracy when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER then
					onOff = "Yes"
				end
				return 'Show Level Completion on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_LEVEL_COMPLETION_ONTIMER = currentBool
			end,
			Info = {"Show information about","level completion when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Show KillStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_KILLSTREAK_ONTIMER = currentBool
			end,
			Info = {"Show information about mob killed","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Show RoomStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ROOMSTREAK_ONTIMER = currentBool
			end,
			Info = {"Show information about rooms entered","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Show TimeStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_TIMESTREAK_ONTIMER = currentBool
			end,
			Info = {"Show information about time spend","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER then
					onOff = "Yes"
				end
				return 'Show Hits Taken on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_HITS_TAKEN_ONTIMER = currentBool
			end,
			Info = {"Show information about hits taken when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER then
					onOff = "Yes"
				end
				return 'Show Ennemy Killed on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.TOGGLE_ENNEMY_KILLED_ONTIMER = currentBool
			end,
			Info = {"Show information about ennemy killed when the timer is ON"}
		}
	)
	
	
	MCM.AddSpace("Advanced Stats", "OnTimer")
	MCM.AddText("Advanced Stats", "OnTimer", function() return "Extra info individual toggle" end)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on accuracy on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ACCURACY_ONTIMER = currentBool
			end,
			Info = {"Show extra information about accuracy when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on Level Completion on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_LEVEL_COMPLETION_ONTIMER = currentBool
			end,
			Info = {"Show extra information about","level completion when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on KillStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_KILLSTREAK_ONTIMER = currentBool
			end,
			Info = {"Show extra information about mob killed","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on RoomStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ROOMSTREAK_ONTIMER = currentBool
			end,
			Info = {"Show extra information about rooms entered","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on TimeStreak on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_TIMESTREAK_ONTIMER = currentBool
			end,
			Info = {"Show extra information about time spend","without being hit when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on Hits Taken on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_HITS_TAKEN_ONTIMER = currentBool
			end,
			Info = {"Show extra information about hits taken when the timer is ON"}
		}
	)
	
	MCM.AddSetting(
		"Advanced Stats",
		"OnTimer",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER
			end,
			Display = function()
				local onOff = "No"
				if AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER then
					onOff = "Yes"
				end
				return 'Extra info on Ennemy Killed on timer : ' .. onOff
			end,
			OnChange = function(currentBool)
				AS.CONFIG.ADDITIONAL_ENNEMY_KILLED_ONTIMER = currentBool
			end,
			Info = {"Show information about ennemy killed when the timer is ON"}
		}
	)
	
	
	
	
end