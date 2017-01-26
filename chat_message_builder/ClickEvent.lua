cClickEvent = {}
cClickEvent.__index = cClickEvent

function cClickEvent.new(a_Action, a_Text)
	local self = setmetatable({}, cClickEvent)
	
	self.m_Action = a_Action
	self.m_Text = a_Text
	
	-- Supported actions:
    -- open_url
    -- open_file
    -- run_command
    -- suggest_command
	
	return self
end
