---@class replica_components
---@field event_trigger_betterlb replica_event_trigger_betterlb

---@class replica_event_trigger_betterlb
---@field inst ent
---@field event_name netvar
---@field type netvar
---@field trigger netvar
local event_trigger_betterlb = Class(
---@param self replica_event_trigger_betterlb
---@param inst ent
function(self, inst)
    self.inst = inst
    self.event_name = net_string(inst.GUID, "event_trigger_betterlb.event_name")
    self.type = net_string(inst.GUID, "event_trigger_betterlb.type")
    self.trigger = net_bool(inst.GUID, "event_trigger_betterlb.trigger",'event_trigger_betterlb_triggered')
end)

function event_trigger_betterlb:SetEventName(event_name)
    self.event_name:set(event_name)
end

function event_trigger_betterlb:GetEventName()
    return self.event_name:value()
end

function event_trigger_betterlb:SetType(type)
    self.type:set(type)
end

function event_trigger_betterlb:GetType()
    return self.type:value()
end

function event_trigger_betterlb:Trigger(value)
    return self.trigger:set(value)
end

return event_trigger_betterlb