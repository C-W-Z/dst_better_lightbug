local main = require('core_betterlb/data/killability')

local props = {}

for _,v in ipairs(main.data) do
    local id = v.id
    if v.set_netvar then
        props[id] = function (self,value)
            self.inst.replica.betterlb[id]:set(value)
        end
    end
end

---comment
---@param player ent
---@param data event_data_killed_betterlb_participate
local function onkilled(player,data)
    if data and player and player.components.betterlb_killability then
        local victim,iskiller = data.victim,data.iskiller
        if victim and victim.prefab then
            local id = main._dict[victim.prefab]
            if id and not player.components.betterlb_killability:CheckID(id) then
                SUGAR_betterlb:declare(id)
                local testfn_extra = main._data_map[id].testfn_extra
                if testfn_extra == nil or testfn_extra(player,victim) then
                    player.components.betterlb_killability:UnlockID(id,victim,iskiller)
                end
            end
        end
    end
end

---@class components
---@field betterlb_killability component_betterlb_killability

---@class component_betterlb_killability
---@field inst ent
local betterlb_killability = Class(
---@param self component_betterlb_killability
---@param inst ent
function(self, inst)
    self.inst = inst

    inst:ListenForEvent('killed_betterlb_participate',onkilled)
end,
nil,
props)

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

function betterlb_killability:OnSave()
    local sav = {}
    for _,v in ipairs(main.data) do
        local id = v.id
        sav[id] = self[id] or nil
    end
    return sav
end

function betterlb_killability:OnLoad(sav)
    if sav then
        for _,v in ipairs(main.data) do
            local id = v.id
            self[id] = sav[id] or nil
            if self[id] then
                local fn_both = v.fn_both
                if fn_both then fn_both(self.inst) end
                local fn_load = v.fn_load
                if fn_load then fn_load(self.inst) end
            end
        end
    end
end

---通过ID检查某个能力有没有解锁
---@param id data_betterlb_killability_id
---@return boolean
---@nodiscard
function betterlb_killability:CheckID(id)
    return self[id] or false
end

---解锁某个id对应的能力
---@param id data_betterlb_killability_id
---@param victim ent|nil
---@param iskiller boolean
function betterlb_killability:UnlockID(id,victim,iskiller)
    if not self[id] then
        self[id] = true
        local _data_map = main._data_map[id]
        if _data_map then
            local fn_both = _data_map.fn_both
            local fn = _data_map.fn
            if fn_both then fn_both(self.inst) end
            if fn then fn(self.inst,victim,iskiller) end
        end
    end
end

return betterlb_killability