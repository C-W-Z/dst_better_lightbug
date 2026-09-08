---@diagnostic disable: lowercase-global, undefined-global, trailing-space

GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

---@type string
local modid = 'betterlb' -- 定义唯一modid

GLOBAL.BETTERLB_API = env

---@type LAN_TOOL_COORDS
COORDS_betterlb = require('core_' .. modid .. '/utils/coords')
---@type LAN_TOOL_SUGARS
SUGAR_betterlb = require('core_' .. modid .. '/utils/sugar')

rawset(GLOBAL, 'COORDS_betterlb', COORDS_betterlb)
rawset(GLOBAL, 'SUGAR_betterlb', SUGAR_betterlb)

PrefabFiles = {
	-- 'betterlb_module_buffs',
	-- 'betterlb_module_dishes',
	-- 'betterlb_module_particle',

}

---@type asset[]
Assets = {

}

----------------------------------------
----------------------------------------
------由于导入文件较多,请务必注意顺序------
------例如钩子文件的顺序------------------
------由于导入文件较多,请务必注意顺序------
----------------------------------------
----------------------------------------

-- 导入mod配置
for _, v in ipairs({
    '_lang',
    '_no_feed',
    '_invincible',
	'_hp',
	'_light_range',
	'_intensity',
}) do TUNING[string.upper('CONFIG_' .. modid .. v)] = GetModConfigData(modid .. v) end


-- 导入常量表
modimport('scripts/core_' .. modid .. '/data/tuning.lua')

-- 导入工具
modimport('scripts/core_' .. modid .. '/utils/_register.lua')

-- 导入功能API
modimport('scripts/core_' .. modid .. '/api/_register.lua')

-- 导入语言文件
modimport('scripts/core_' .. modid .. '/languages/' .. TUNING[string.upper('CONFIG_' .. modid .. '_LANG')] .. '.lua')

-- 皮肤API
modimport('scripts/api_skins/' .. modid .. '_skins') -- 皮肤api

-- 导入人物
-- modimport('scripts/data_avatar/data_avatar_xxx.lua')

-- 导入调用器
-- modimport('scripts/core_'..modid..'/callers/caller_attackperiod.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_badge.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_ca.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_changeactionsg.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_container.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_dish.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_keyhandler.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_onlyusedby.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_recipes.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_stack.lua')


-- 导入零散功能模块 (自用 可以无视) (如果你要启用某个模块, 先看该manager文件里面的置顶注释)
-- modimport('scripts/core_betterlb/managers/atk_speed_from_alt.lua') -- 功能(无需修改): alt写的修改攻速模块 修正版
-- modimport('scripts/core_betterlb/managers/bugfix_aoetargeting.lua') -- 当你使用官方组件来写技能时,貌似会因为没有正确移除 reticule 组件,导致玩家的轮盘施法放不出来,本文件就是用来修复这个bug的
-- modimport('scripts/core_betterlb/managers/bugfix_souljump.lua') -- 当你使用官方组件来写武器技能时, 会导致和 小恶魔的灵魂跳跃 冲突, 具体我忘了, 总之这个文件就是用来修复这个bug的
-- modimport('scripts/core_betterlb/managers/build_data_transfer.lua') -- 功能(需要填写): 制作物品过程涉及数据传输 (只能传输1件原材料的数据)
-- modimport('scripts/core_betterlb/managers/cantequip_whennodurability.lua') -- 功能(无需修改): 本文件用来管理,装备耐久用尽时的逻辑
-- modimport('scripts/core_betterlb/managers/cd_in_itemtile.lua') -- 功能(无需修改): 在物品栏以数字形式显示的cd
-- modimport('scripts/core_betterlb/managers/dmg_sys.lua') -- 管理: 用这个文件管理伤害处理吧
-- modimport('scripts/core_betterlb/managers/event_hook.lua') -- 功能(需要填写): 勾 event
-- modimport('scripts/core_betterlb/managers/extra_actions.lua') -- 功能(需要填写): 组件动作拓展(空手对地等)
-- modimport('scripts/core_betterlb/managers/hovertext.lua') -- 功能(无需修改): 添加悬浮提示
-- modimport('scripts/core_betterlb/managers/invincible.lua') -- 功能(无需修改): 设置无敌的
modimport('scripts/core_betterlb/managers/is_mod_enabled.lua') -- 功能(无需修改): 判断某个mod有没有开启 的前置
-- modimport('scripts/core_betterlb/managers/killability.lua') -- 功能(需要填写): 击杀获取能力模板
-- modimport('scripts/core_betterlb/managers/last_atk_weapon.lua') -- 功能(无需修改): 获取攻击者上次使用的武器
modimport('scripts/core_betterlb/managers/misc.lua') -- 杂项
-- modimport('scripts/core_betterlb/managers/participate_kill.lua') -- 功能(无需修改): 联合击杀(参与击杀), 判断生物死亡时, 某个玩家有没有贡献伤害(参与战斗)
-- modimport('scripts/core_betterlb/managers/quick_announce.lua') -- 功能(需要填写): alt + 左键点击库存物品宣告
-- modimport('scripts/core_betterlb/managers/skin_container_ui.lua') -- 功能(需要填写): 箱子的UI皮肤
-- modimport('scripts/core_betterlb/managers/sort_recipes.lua') -- 功能(需要填写): 给配方排序
-- modimport('scripts/core_betterlb/managers/trade.lua') -- 功能(无需修改,但需要填写其他地方): 添加通用的交易升级功能
modimport('scripts/core_betterlb/managers/_auto_regist_animandtex.lua') -- (必须)无需关心: 帮助其他框架载入材质和注册用的


-- 导入UI
-- modimport('scripts/core_'..modid..'/ui/template.lua')

-- 注册客机组件
-- AddReplicableComponent('xxx')

-- 导入 skins
---@type string[]
local skin_files = {
	-- 'myspear',
}
for _, v in ipairs(skin_files) do
	modimport('scripts/core_' .. modid .. '/skins/' .. v .. '.lua')
end

-- 导入 sg
---@type string[]
local sg_files = {
	-- blanksg,
}
for _, v in ipairs(sg_files) do
	modimport('scripts/core_' .. modid .. '/sg/' .. v .. '.lua')
end

-- 导入钩子 It's my勾
---@type string[]
local files_hook = {

}
for _, v in ipairs(files_hook) do
	modimport('scripts/core_' .. modid .. '/hooks/' .. v .. '.lua')
end

--------------------------------------------------------------------------
-- 修改球狀光蟲 (lightflier) 本體屬性與行為
--------------------------------------------------------------------------
---@param inst ent
AddPrefabPostInit("lightflier", function(inst)
    if not TheWorld.ismastersim then return end

    -- 光照範圍修改
    if inst.Light then
		inst.Light:SetIntensity(TUNING[string.upper('CONFIG_' .. modid .. '_intensity')])
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

        -- 覆寫 CanMurder 方法以禁用背包謀殺
        -- if DISABLE_MURDER then
        --     inst.components.health.CanMurder = function(self) return false end
        -- end
    end

    -- C. 無需餵食（移除腐爛/餓死組件）
    if TUNING[string.upper('CONFIG_' .. modid .. '_no_feed')] and inst.components.perishable then
        inst:RemoveComponent("perishable")
        inst:RemoveTag("show_spoilage")
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
-- if WANDER_RADIUS ~= 10 then
--     local LightFlierBrain = require("brains/lightflierbrain")

--     -- 使用 debug.getupvalue 找出 lightflierbrain 內的局部變量 MAX_WANDER_DIST 並修改
--     local idx = 1
--     while true do
--         local name, value = debug.getupvalue(LightFlierBrain.OnStart, idx)
--         if not name then break end
--         if name == "MAX_WANDER_DIST" then
--             debug.setupvalue(LightFlierBrain.OnStart, idx, WANDER_RADIUS)
--             break
--         end
--         idx = idx + 1
--     end
-- end
