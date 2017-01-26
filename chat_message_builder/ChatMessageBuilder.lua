cChatMessageBuilder = {}
cChatMessageBuilder.__index = cChatMessageBuilder

--[[
Ref: http://wiki.vg/Chat

This class can be used to create a chat messsage that can
run a command on click, add text to textbox, insert text on shift + click,
show text if mouse is over it.

Use the function SendMessageRaw from a player instance to send,
the json string: a_Player:SendMessageRaw(test:Create())


## Examples ##

Text: "Welcome to minecraft!"

No colors and style:
	local test = cChatMessageBuilder.new("Welcome to minecraft!")


The text is red:
	local test = cChatMessageBuilder.new("Welcome to minecraft!"):Color(cChatColor.Red)
	
	
Set text minecraft to bold and color yellow:
	local test = cChatMessageBuilder.new("Welcome to "):Color(cChatColor.Red):
	Append(" minecraft!"):Bold():Color(cChatColor.Yellow)


Run command help on click:
	local test = cChatMessageBuilder.new("Welcome to minecraft!"):Color(cChatColor.Red):
	Click("run_command", "/help")


Show text "Good luck and have fun :-)", if mouse is over text
	local test = cChatMessageBuilder.new("Welcome to minecraft!"):Color(cChatColor.Red):
	Click("run_command", "/help"):Hover("show_text", cChatMessageBuilder.new("Good luck and have fun :-)"))


And at last, the hover text with color light blue:
		local test = cChatMessageBuilder.new("Welcome to minecraft!"):Color(cChatColor.Red):
		Click("run_command", "/help"):Hover("show_text", cChatMessageBuilder.new("Good luck and have fun :-)"):
		Color(cChatColor.LightBlue))
--]]


--- Create a message builder.
-- The arg can be a single String or multiple Strings, 
-- separated by a comma.
function cChatMessageBuilder.new(...)
	local self = setmetatable({}, cChatMessageBuilder)
	
	-- List of cChatMessagePart
	self.m_Parts = {}
	
	-- The current message part
	self.m_Current = cChatMessagePart.new(self:CreateText(arg))
	
	-- Will contain the created json string, if the function Create has been called
	self.m_MessageJson = nil
	
	return self
end



--- Builds the table to a string together
-- a_Arr: Table
function cChatMessageBuilder:CreateText(a_Arr)
	if #a_Arr == 1 then
		return a_Arr[1]
	else
		local text = ""
		for _, v in ipairs(a_Arr) do
			text = text .. v
		end
		return text
	end
end



--- Adds a new message part with the text
-- a_Text: The arg can be a single String or multiple Strings, 
-- separated by a comma.
function cChatMessageBuilder:Append(...)
	table.insert(self.m_Parts, self.m_Current)
	self.m_Current = cChatMessagePart.new(self:CreateText(arg))
	return self
end



--- Set the color in current message part
-- a_Color: cChatColor
function cChatMessageBuilder:Color(a_Color)
	assert(COLORS_CUBERITE_MC[a_Color] ~= nil, "Invalid cChatColor.")

	self.m_Current.m_Color = a_Color
	return self
end



--- Set bold to true in current message part
function cChatMessageBuilder:Bold()
	self.m_Current.m_Bold = true
	return self
end



--- Set Italic to true in current message part
function cChatMessageBuilder:Italic()
	self.m_Current.m_Italic = true
	return self
end



--- Set Underlined to true in current message part
function cChatMessageBuilder:Underlined()
	self.m_Current.m_Underlined = true
	return self
end



--- Set Striketrough to true in current message part
function cChatMessageBuilder:Striketrough()
	self.m_Current.m_Striketrough = true
	return self
end



--- Set Obfuscated to true in current message part
function cChatMessageBuilder:Obfuscated()
	self.m_Current.m_Obfuscated = true
	return self
end



--- Set insertion text in current message part
function cChatMessageBuilder:Insertion(a_Insertion)
	self.m_Current.m_Insertion = a_Insertion
	return self
end



--- Add click event in current message part
-- a_Clickaction: A String
	-- open_url
    -- open_file
    -- run_command
    -- suggest_command
-- a_Text: A string
	-- open_url:		HTTP link
	-- open_file:		Path to file
	-- run_command:		Command to run, example "/help"
	-- suggest_command:	Added to the chatbar content
function cChatMessageBuilder:Click(a_Clickaction, a_Text)
	self.m_Current.m_ClickEvent = cClickEvent.new(a_Clickaction, a_Text)
	return self
end



--- Add hover event in current message part
-- a_Hoveraction: A String
    -- show_text
    -- show_achievement
    -- show_item
-- a_ChatMessageBuilder:
-- A instance of cChatMessageBuilder. Don't call function Create(),
-- if the message is completed
function cChatMessageBuilder:Hover(a_Hoveraction, a_ChatMessageBuilder)
	self.m_Current.m_HoverEvent = cHoverEvent.new(a_Hoveraction, a_ChatMessageBuilder)
	return self
end



--- Buils the json string and returns it.
function cChatMessageBuilder:Create()
	-- Check if already created
	if self.m_MessageJson then
		return self.m_MessageJson
	end
	
	-- Add current part to list
	table.insert(self.m_Parts, self.m_Current)
	
	-- The table for all parts
	local tbMessage = {}
	
	-- Loop over every message part
	for _, messagePart in ipairs(self.m_Parts) do
		local tbPart = {}
		
		-- Set text
		tbPart["text"] = messagePart.m_Text
		
		-- Set color
		tbPart["color"] = COLORS_CUBERITE_MC[messagePart.m_Color]
		
		-- Set style
		tbPart["obfuscated"] = messagePart.m_Obfuscated
		tbPart["bold"] = messagePart.m_Bold
		tbPart["strikethrough"] = messagePart.m_Striketrough
		tbPart["underlined"] = messagePart.m_Underlined
		tbPart["italic"] = messagePart.m_Italic

		-- Add click part
		if messagePart.m_ClickEvent ~= nil then
			local tbClick = {}
			tbClick["action"] = messagePart.m_ClickEvent.m_Action
			tbClick["value"] = messagePart.m_ClickEvent.m_Text
			tbPart["clickEvent"] =  tbClick
		end
		
		-- Add hover part
		if messagePart.m_HoverEvent ~= nil then
			local tbHover = {}
			tbHover["action"] = messagePart.m_HoverEvent.m_Action
			tbHover["value"] = messagePart.m_HoverEvent:Create()
			tbPart["hoverEvent"] = tbHover			
		end
		
		table.insert(tbMessage, tbPart)
	end
	
	self.m_MessageJson = cJson:Serialize(tbMessage)
	return self.m_MessageJson
end
