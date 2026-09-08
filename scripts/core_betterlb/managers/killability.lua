-- hide
-- 功能(需要填写): 击杀获取能力模板

---1. (填写)数据表: core_betterlb/data/killability.lua
---2. 组件和replica: betterlb_killability

---给哪些角色添加
local avatar_prefabs = {
    -- 'webbert',
}
AddReplicableComponent('betterlb_killability')
for _,v in ipairs(avatar_prefabs) do
    AddPrefabPostInit(v, function (inst)
        if not TheWorld.ismastersim then
            return inst
        end
        inst:AddComponent('betterlb_killability')
    end)
end