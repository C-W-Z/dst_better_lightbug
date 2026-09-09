---@diagnostic disable: lowercase-global, undefined-global, trailing-space

GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

---@type string
local modid = 'betterlb' -- 定义唯一modid

GLOBAL.BETTERLB_API = env

PrefabFiles = {
    -- 'betterlb_module_buffs',
    -- 'betterlb_module_dishes',
    -- 'betterlb_module_particle',

}

---@type asset[]
Assets = {

}

-- 导入mod配置
for _, v in ipairs({
    '_lang',
    '_migrate',
    '_no_feed',
    '_invincible',
    '_hp',
    '_light_range',
    -- '_intensity',
    -- '_wander_range',
}) do TUNING[string.upper('CONFIG_' .. modid .. v)] = GetModConfigData(modid .. v) end

-- 無需餵食（移除腐爛/餓死組件）
if TUNING[string.upper('CONFIG_' .. modid .. '_no_feed')] then
    -- 備份原版函數
    local old_MakeFeedableSmallLivestock = GLOBAL.MakeFeedableSmallLivestock

    ---覆寫 MakeFeedableSmallLivestock
    ---@param _inst ent
    ---@param starvetime any
    ---@param oninventory any
    ---@param ondropped any
    ---@return nil
    GLOBAL.MakeFeedableSmallLivestock = function(_inst, starvetime, oninventory, ondropped)
        -- 判斷是否為球狀光蟲
        if _inst.prefab == "lightflier" or _inst:HasTag("lightflier") then
            -- 執行 Pristine (添加 small_livestock 標籤等)
            GLOBAL.MakeFeedableSmallLivestockPristine(_inst)

            -- 保留飲食組件
            if _inst.components.eater == nil then
                _inst:AddComponent("eater")
            end

            -- 不調用 MakeSmallPerishableCreature (不添加 perishable)
            -- 直接把原版的 OnPutInInventory 與 OnDropped 綁定給 inventoryitem
            if _inst.components.inventoryitem ~= nil then
                _inst.components.inventoryitem:SetOnPutInInventoryFn(oninventory)
                _inst.components.inventoryitem:SetOnDroppedFn(ondropped)
            end

            return
        end

        -- 其他生物（如高鳥幼崽、兔子等）走原版邏輯
        return old_MakeFeedableSmallLivestock(_inst, starvetime, oninventory, ondropped)
    end
end

--------------------------------------------------------------------------
-- 修改球狀光蟲 (lightflier) 本體屬性與行為
--------------------------------------------------------------------------
---@param inst ent
AddPrefabPostInit("lightflier", function(inst)
    if not TheWorld.ismastersim then return end

    -- 光照範圍修改
    if inst.Light then
        -- inst.Light:SetIntensity(TUNING[string.upper('CONFIG_' .. modid .. '_intensity')])
        inst.Light:SetRadius(1.8 * TUNING[string.upper('CONFIG_' .. modid .. '_light_range')])
    end

    -- 血量、無敵、自動回血
    if inst.components.health then
        inst.components.health:SetMaxHealth(TUNING[string.upper('CONFIG_' .. modid .. '_hp')])

        if TUNING[string.upper('CONFIG_' .. modid .. '_invincible')] then
            inst.components.health:SetInvincible(true)
        end

        -- if REGEN_HP > 0 then
        --     inst.components.health:StartRegen(REGEN_HP, 1)
        -- end
    end

    -- D. 友方保護標籤（防止阿比蓋爾、暗影角鬥士等友方/召喚物攻擊）
    -- DST 中阿比蓋爾與暗影角鬥士會自動忽略帶有 "companion" 或 "notarget" Tag 的單位
    -- if FRIENDLY_MODE == 2 then
    --     inst:AddTag("companion")
    --     inst:AddTag("notarget")
    -- elseif FRIENDLY_MODE == 1 then
    --     -- 僅在進入隊列 (跟隨) 時添加友方標籤
    --     local follower = inst.components.formationfollower
    --     if follower then
    --         local old_onenter = follower.onenterformationfn
    --         follower.onenterformationfn = function(inst, leader)
    --             if old_onenter then old_onenter(inst, leader) end
    --             inst:AddTag("companion")
    --             inst:AddTag("notarget")
    --         end

    --         local old_onleave = follower.onleaveformationfn
    --         follower.onleaveformationfn = function(inst, leader)
    --             if old_onleave then old_onleave(inst, leader) end
    --             inst:RemoveTag("companion")
    --             inst:RemoveTag("notarget")
    --         end
    --     end
    -- end
end)

--------------------------------------------------------------------------
-- 修改隊列跟隨上限 (formationleader)
--------------------------------------------------------------------------
-- 隊列生成時會建立 formationleader Prefab，並預設 max_formation_size = 3
-- AddPrefabPostInit("formationleader", function(inst)
--     if not TheWorld.ismastersim then return end

--     -- 延遲一幀執行，覆寫掉原代碼硬編碼的 3 隻限制
--     inst:DoTaskInTime(0, function()
--         if inst.components.formationleader and inst.components.formationleader.formation_type == "lightflier" then
--             inst.components.formationleader.max_formation_size = MAX_FOLLOW
--         end
--     end)
-- end)

--------------------------------------------------------------------------
-- 修改非跟隨狀態的遊蕩範圍 (Brain Upvalue 修改)
--------------------------------------------------------------------------
-- if TUNING[string.upper('CONFIG_' .. modid .. '_wander_range')] ~= 10 then
--     local LightFlierBrain = require("brains/lightflierbrain")

--     -- 使用 debug.getupvalue 找出 lightflierbrain 內的局部變量 MAX_WANDER_DIST 並修改
--     local idx = 1
--     while true do
--         local name, value = debug.getupvalue(LightFlierBrain.OnStart, idx)
--         if not name then break end
--         if name == "MAX_WANDER_DIST" then
--             debug.setupvalue(LightFlierBrain.OnStart, idx, TUNING[string.upper('CONFIG_' .. modid .. '_wander_range')])
--             break
--         end
--         idx = idx + 1
--     end
-- end

-- ==========================================================================
-- 球狀光蟲 跨世界/上下地洞 跟隨邏輯
-- ==========================================================================
if TUNING[string.upper('CONFIG_' .. modid .. '_migrate')] then
    -- 獲取當前跟隨該玩家的所有光蟲
    ---comment
    ---@param player ent
    ---@return table
    local function GetFollowingLightfliers(player)
        local fliers = {}
        -- 光蟲的隊列隊長實體保存在玩家的 _lightflier_formation 變數中
        if player._lightflier_formation and player._lightflier_formation:IsValid() then
            local formationleader = player._lightflier_formation.components.formationleader
            if formationleader and formationleader.formation then
                -- 遍歷隊列中的所有光蟲成員
                for follower, _ in pairs(formationleader.formation) do
                    if follower and follower:IsValid() then
                        table.insert(fliers, follower)
                    end
                end
            end
        end
        return fliers
    end

    AddPlayerPostInit(function(inst)
        if not GLOBAL.TheWorld.ismastersim then return end

        if inst._lightflier_migration_installed then return end
        inst._lightflier_migration_installed = true

        inst.lightflier_followers = inst.lightflier_followers or {}

        local old_OnDespawn = inst.OnDespawn
        local old_OnSave = inst.OnSave
        local old_OnLoad = inst.OnLoad

        -- 1. 玩家即將消失（上下地洞 / 切換地圖 / 下線）
        inst.OnDespawn = function(_inst, migrationdata, ...)
            local fliers = GetFollowingLightfliers(_inst)

            for _, follower in ipairs(fliers) do
                -- 保存光蟲的完整數據（血量、屬性等）
                local savedata = follower:GetSaveRecord()
                table.insert(_inst.lightflier_followers, savedata)

                -- 防止在舊世界留存存檔，並順滑銷毀舊實體
                follower.persists = false
                follower:AddTag("notarget")
                follower:AddTag("NOCLICK")

                -- 生成消失特效並清除
                follower:DoTaskInTime(math.random() * 0.2, function(f)
                    if f:IsValid() then
                        local fx = GLOBAL.SpawnPrefab("spawn_fx_small")
                        if fx then
                            fx.Transform:SetPosition(f.Transform:GetWorldPosition())
                        end
                        f:Remove()
                    end
                end)
            end

            if old_OnDespawn then
                return old_OnDespawn(_inst, migrationdata, ...)
            end
        end

        -- 2. 保存玩家存檔數據
        inst.OnSave = function(_inst, data, ...)
            if data then
                data.lightflier_followers = _inst.lightflier_followers
            end
            if old_OnSave then
                return old_OnSave(_inst, data, ...)
            end
        end

        -- 3. 加載新世界（進地洞/出地洞/上線）後恢復光蟲
        inst.OnLoad = function(_inst, data, ...)
            if data and data.lightflier_followers and #data.lightflier_followers > 0 then
                for _, savedata in ipairs(data.lightflier_followers) do
                    _inst:DoTaskInTime(0.2 * math.random() + 0.1, function()
                        if not _inst:IsValid() then return end

                        -- 重新生成光蟲
                        local follower = GLOBAL.SpawnSaveRecord(savedata)
                        if follower and follower:IsValid() then
                            -- 移動到玩家身邊
                            follower.Transform:SetPosition(_inst.Transform:GetWorldPosition())

                            if follower.sg then
                                follower.sg:GoToState("idle")
                            end

                            -- 生成出現特效
                            local fx = GLOBAL.SpawnPrefab("spawn_fx_small")
                            if fx then
                                fx.Transform:SetPosition(follower.Transform:GetWorldPosition())
                            end

                            -- 讓光蟲重新開始尋找跟隨目標 (會在1秒內自動重新與玩家組隊)
                            if follower.components.formationfollower then
                                follower.components.formationfollower:StartUpdating()
                            end
                        end
                    end)
                end
                -- 清空暫存清單
                _inst.lightflier_followers = {}
            end

            if old_OnLoad then
                return old_OnLoad(_inst, data, ...)
            end
        end
    end)
end
