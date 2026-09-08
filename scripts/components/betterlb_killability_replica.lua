local main = require('core_betterlb/data/killability')

---@class replica_components
---@field betterlb_killability replica_betterlb_killability

---@class replica_betterlb_killability
---@field inst ent
local betterlb_killability = Class(
---@param self replica_betterlb_killability
---@param inst ent
function(self, inst)
    self.inst = inst
    for _,v in ipairs(main.data) do
        local id = v.id
        self[id] = net_bool(inst.GUID,'betterlb_killability.'..id)
    end
end)

---@return string
---@nodiscard
function betterlb_killability:GetDebugString()
    local str = '--------------------------\n'
    for _,v in pairs(main.data) do
        str = str .. subfmt('{id} | {mob_name} | 解锁: | {unlocked}\n',{id = v.id, mob_name = STRINGS.NAMES[string.upper(v.kill_prefab[1])] or v.kill_prefab[1], unlocked = self:CheckID(v.id) and 'Yes' or 'No'}) .. '\n'
    end
    str = str .. '--------------------------'
    return str
end

---通过ID检查某个能力有没有解锁(需要注意有没有设置网络变量)
---@param id data_betterlb_killability_id
---@return boolean
---@nodiscard
function betterlb_killability:CheckID(id)
    assert(self[id] ~= nil, '组件 betterlb_killability 的属性 '..id..' 没有设置网络变量!')
    return self[id]:value() or false
end

return betterlb_killability