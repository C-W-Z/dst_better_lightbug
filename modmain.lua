---@diagnostic disable: lowercase-global, undefined-global, trailing-space

GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

---@type string
local modid = 'betterlb' -- 定义唯一modid

GLOBAL.BETTERLB_API = env

PrefabFiles = {}

---@type asset[]
Assets = {}

-- 导入mod配置
local MIGRATE = GetModConfigData(modid .. '_migrate')
local NO_FEED = GetModConfigData(modid .. '_no_feed')
local INVINCIBLE = GetModConfigData(modid .. '_invincible')
local MAX_HP = GetModConfigData(modid .. '_hp')
local REGEN_HP = GetModConfigData(modid .. '_regen_hp')
local LIGHT_RANGE = GetModConfigData(modid .. '_light_range')
local MAX_FOLLOW = GetModConfigData(modid .. '_max_follow')

local W_INVINCIBLE = GetModConfigData(modid .. '_w_invincible')
local W_MAX_HP = GetModConfigData(modid .. '_w_hp')
local W_REGEN_HP = GetModConfigData(modid .. '_w_regen_hp')
local W_LIGHT_RANGE = GetModConfigData(modid .. '_w_light_range')
local W_MAX_FOLLOW = GetModConfigData(modid .. '_w_max_follow')
local W_LIFETIME = GetModConfigData(modid .. '_w_lifetime')

-- 無需餵食（移除腐爛/餓死組件）
if NO_FEED then
    -- 備份原版函數
    -- 這裡GLOBAL似乎是必要的
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
AddPrefabPostInit("lightflier", function(inst)
    if not TheWorld.ismastersim then return end

    -- 光照範圍修改
    if LIGHT_RANGE and inst.Light then
        -- inst.Light:SetIntensity(TUNING[string.upper('CONFIG_' .. modid .. '_intensity')])
        inst.Light:SetRadius(1.8 * LIGHT_RANGE)
    end

    -- 血量、無敵、自動回血
    if inst.components.health then
        if MAX_HP then
            inst.components.health:SetMaxHealth(MAX_HP)
        end

        if INVINCIBLE then
            inst.components.health:SetInvincible(true)
        end

        if REGEN_HP > 0 then
            inst.components.health:StartRegen(REGEN_HP * MAX_HP, 1)
        end
    end
end)

-- 沃姆伍德的版本
AddPrefabPostInit("wormwood_lightflier", function(inst)
    if not TheWorld.ismastersim then return end

    -- 光照範圍修改
    if W_LIGHT_RANGE and inst.Light then
        -- inst.Light:SetIntensity(TUNING[string.upper('CONFIG_' .. modid .. '_intensity')])
        inst.Light:SetRadius(1.8 * W_LIGHT_RANGE)
    end

    -- 血量、無敵、自動回血
    if inst.components.health then
        if W_MAX_HP then
            inst.components.health:SetMaxHealth(W_MAX_HP)
        end

        if W_INVINCIBLE then
            inst.components.health:SetInvincible(true)
        end

        if W_REGEN_HP > 0 then
            inst.components.health:StartRegen(W_REGEN_HP * W_MAX_HP, 1)
        end
    end
end)

if W_LIFETIME then
    TUNING.WORMWOOD_PET_LIGHTFLIER_LIFETIME = W_LIFETIME
end

--------------------------------------------------------------------------
-- 修改隊列跟隨上限 (formationleader)
--------------------------------------------------------------------------
if MAX_FOLLOW then
    -- 隊列生成時會建立 formationleader Prefab，並預設 max_formation_size = 3
    AddPrefabPostInit("formationleader", function(inst)
        if not TheWorld.ismastersim then return end

        -- 延遲一幀執行，覆寫掉原代碼硬編碼的 3 隻限制
        inst:DoTaskInTime(0, function()
            if inst.components.formationleader and inst.components.formationleader.formation_type == "lightflier" then
                inst.components.formationleader.max_formation_size = MAX_FOLLOW
            end
        end)
    end)
end

-- 攔截植物人，覆寫硬編碼的重算邏輯與寵物上限
AddPrefabPostInit("wormwood", function(inst)
    if not TheWorld.ismastersim then return end

    -- 確保 petleash 吃到新的上限 (防止 TUNING 載入順序問題)
    if W_MAX_FOLLOW and inst.components.petleash then
        inst.components.petleash:SetMaxPetsForPrefab("wormwood_lightflier", W_MAX_FOLLOW)
    end

    -- 覆寫植物人身上的光蟲重算函數，移除原本硬編碼的 1.8
    if W_LIGHT_RANGE then
        ---@param _inst ent
        inst.RecalculateLightFlierLight = function(_inst)
            local pets = _inst.components.petleash and _inst.components.petleash:GetPetsWithPrefab("wormwood_lightflier") or
                nil
            if pets == nil then return end

            -- 使用新的 TUNING 上限來計算倍率 (數量越多，範圍越大的機制)
            local mult = Remap(#pets, 1, TUNING.WORMWOOD_PET_LIGHTFLIER_LIMIT, 1, 2)

            for i, pet in ipairs(pets) do
                if pet.Light then
                    -- 將硬編碼的 1.8 改為我們的自定義基礎半徑
                    pet.Light:SetRadius(W_LIGHT_RANGE * mult)
                end
            end
        end
    end
end)

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
if MIGRATE then
    -- 獲取當前跟隨該玩家的所有光蟲
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
        if not TheWorld.ismastersim then return end

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
                        local fx = SpawnPrefab("spawn_fx_small")
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
                        local follower = SpawnSaveRecord(savedata)
                        if follower and follower:IsValid() then
                            -- 移動到玩家身邊
                            follower.Transform:SetPosition(_inst.Transform:GetWorldPosition())

                            if follower.sg then
                                follower.sg:GoToState("idle")
                            end

                            -- 生成出現特效
                            local fx = SpawnPrefab("spawn_fx_small")
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
