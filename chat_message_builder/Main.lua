function Initialize(Plugin)
	Plugin:SetName("Test_ChatMessageBuilder")
	Plugin:SetVersion(1)
	
	-- Colors: Cuberite to Minecraft
	COLORS_CUBERITE_MC = {}
	COLORS_CUBERITE_MC[cChatColor.Black] = "black"
	COLORS_CUBERITE_MC[cChatColor.Blue] = "dark_aqua"
	COLORS_CUBERITE_MC[cChatColor.Red] = "dark_red"
	COLORS_CUBERITE_MC[cChatColor.White] = "white"
	COLORS_CUBERITE_MC[cChatColor.Yellow] = "yellow"
	COLORS_CUBERITE_MC[cChatColor.Gold] = "gold"
	COLORS_CUBERITE_MC[cChatColor.LightGray] = "gray"
	COLORS_CUBERITE_MC[cChatColor.Gray] = "dark_gray"
	COLORS_CUBERITE_MC[cChatColor.DarkPurple] = "blue"
	COLORS_CUBERITE_MC[cChatColor.Green] = "dark_green"
	COLORS_CUBERITE_MC[cChatColor.LightBlue] = "aqua"
	COLORS_CUBERITE_MC[cChatColor.LightGreen] = "green"
	COLORS_CUBERITE_MC[cChatColor.LightPurple] = "light_purple"
	COLORS_CUBERITE_MC[cChatColor.Navy] = "dark_blue"
	COLORS_CUBERITE_MC[cChatColor.Purple] = "dark_purple"
	COLORS_CUBERITE_MC[cChatColor.Rose] = "red"
	
	-- Style
	COLORS_CUBERITE_MC[cChatColor.Plain] = "reset"
	
	cPluginManager.BindCommand("/test", "test", CmdTest, " - Prints the message")
	return true
end



function CmdTest(a_Split, a_Player)
	local test = cChatMessageBuilder.new("Welcome to minecraft!")
		:Color(cChatColor.Blue)
		:Click("run_command", "/help"):Hover("show_text", cChatMessageBuilder.new("Good luck and have fun :-)")
		:Color(cChatColor.LightBlue))
	
	a_Player:SendMessageRaw(test:Create())
	return true
end
