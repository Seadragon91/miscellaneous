cChatMessagePart = {}
cChatMessagePart.__index = cChatMessagePart

function cChatMessagePart.new(a_Text)
	local self = setmetatable({}, cChatMessagePart)

	self.m_Text = a_Text
	self.m_Color = cChatColor.White
	self.m_Bold = false
	self.m_Italic = false
	self.m_Underlined = false
	self.m_Strikethrough = false
	self.m_Obfuscated = false

	self.m_ClickEvent = nil
	self.m_HoverEvent = nil

	return self
end
