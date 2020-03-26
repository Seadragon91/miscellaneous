cHoverEvent = {}
cHoverEvent.__index = cHoverEvent

function cHoverEvent.new(a_Action, a_ChatMessageBuilder)
	local self = setmetatable({}, cHoverEvent)

	self.m_Action = a_Action
	self.m_ChatMessageBuilder = a_ChatMessageBuilder

	-- Supported actions:
	-- show_text
	-- show_achievement
	-- show_item

	return self
end



function cHoverEvent:Create()
	-- Add current part to list
	table.insert(self.m_ChatMessageBuilder.m_Parts, self.m_ChatMessageBuilder.m_Current)

	-- The table for all parts
	local tbHoverMessage = {}
	for _, hoverPart in ipairs(self.m_ChatMessageBuilder.m_Parts) do
		local tbPart = {}

		-- -- Set text
		tbPart.text = hoverPart.m_Text

		-- Set color
		tbPart.color = COLORS_CUBERITE_MC[hoverPart.m_Color]

		-- Set style
		tbPart.obfuscated = hoverPart.m_Obfuscated
		tbPart.bold = hoverPart.m_Bold
		tbPart.strikethrough = hoverPart.m_Striketrough
		tbPart.underlined = hoverPart.m_Underlined
		tbPart.italic = hoverPart.m_Italic

		table.insert(tbHoverMessage, tbPart)
	end

	return tbHoverMessage
end
