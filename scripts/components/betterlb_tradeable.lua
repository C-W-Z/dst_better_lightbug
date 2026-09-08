---@class components
---@field betterlb_tradeable component_betterlb_tradeable # 不用管我(这个组件是为 通用交易 功能服务的 )

---@class component_betterlb_tradeable
---@field inst ent
local betterlb_tradeable = Class(
---@param self component_betterlb_tradeable
---@param inst ent
function(self, inst)
    self.inst = inst
end,
nil,
{
})

return betterlb_tradeable