---@diagnostic disable: lowercase-global, undefined-global, trailing-space
-- 本地化
local op = { { 'A', 97 }, { 'B', 98 }, { 'C', 99 }, { 'D', 100 }, { 'E', 101 }, { 'F', 102 }, { 'G', 103 }, { 'H', 104 }, { 'I', 105 }, { 'J', 106 }, { 'K', 107 }, { 'L', 108 }, { 'M', 109 }, { 'N', 110 }, { 'O', 111 }, { 'P', 112 }, { 'Q', 113 }, { 'R', 114 }, { 'S', 115 }, { 'T', 116 }, { 'U', 117 }, { 'V', 118 }, { 'W', 119 }, { 'X', 120 }, { 'Y', 121 }, { 'Z', 122 }, { '0', 48 }, { '1', 49 }, { '2', 50 }, { '3', 51 }, { '4', 52 }, { '5', 53 }, { '6', 54 }, { '7', 55 }, { '8', 56 }, { '9', 57 } }

local modid = 'betterlb'
local LANGS = {
    ['zh'] = {
        name = '更好的球状光虫',
        description = '详细功能请查看模组设置。\n\n兼容以下模組：\n- 沃姆伍德大修：月裔萌芽\n- 沃姆伍德全面重做！\n\n無法調整「数值怪沃姆伍德」模組的沃姆伍德光蟲',
        config = {
            { modid .. '_migrate', '光虫跟随上下地洞', '跟随的光虫会随你上下地洞', true, {
                { '禁用', false },
                { '启用', true },
            } },
            { modid .. '_no_feed', '光虫无需喂食', '', true, {
                { '禁用', false },
                { '启用', true },
            } },
            { modid .. '_invincible', '光虫无敌', '', true, {
                { '禁用', false },
                { '启用', true },
            } },
            { modid .. '_hp', '光虫血量', '调整光虫血量', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '25（原版）', 25 },
                { '50', 50 },
                { '100', 100 },
                { '250', 250 },
                { '500', 500 },
                { '1000', 1000 },
            } },
            { modid .. '_regen_hp', '每秒回血量', '调整光虫每秒自动回复最大生命值多少比例的血量', 0, {
                { '禁用', 0 },
                { '1%', 0.01 },
                { '2%', 0.02 },
                { '3%', 0.03 },
                { '4%', 0.04 },
                { '5%', 0.05 },
                { '10%', 0.1 },
                { '25%', 0.25 },
                { '50%', 0.5 },
            } },
            { modid .. '_light_range', '光虫光照范围', '调整光虫照明半径', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '1x', 1 },
                { '1.5x', 1.5 },
                { '2x', 2 },
                { '2.5x', 2.5 },
                { '3x', 3 },
                { '4x', 4 },
                { '5x', 5 },
            } },
            { modid .. '_max_follow', '最大跟随数量', '调整最多可以有几只光虫跟随玩家', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '1', 1 },
                { '2', 2 },
                { '3（原版）', 3 },
                { '4', 4 },
                { '5', 5 },
                { '6', 6 },
                { '7', 7 },
                { '8', 8 },
                { '9', 9 },
            } },
            -- { modid .. '_wander_range', '野生光虫游荡范围', '调整野生光虫游荡半径', 10, {
            --     { '0', 0 },
            --     { '1', 1 },
            --     { '2', 2 },
            --     { '3', 3 },
            --     { '4', 4 },
            --     { '5', 5 },
            --     { '10（原版）', 10 },
            --     { '15', 15 },
            --     { '20', 20 },
            -- } },
            { '沃姆伍德的光虫' },
            { modid .. '_w_lifetime', '光虫存活时间', '', 10, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '1天', 1 },
                { '2天', 2 },
                { '2.5天（原版）', 2.5 },
                { '5天', 5 },
                { '7.5天', 7.5 },
                { '10天', 10 },
                { '15天', 15 },
                { '20天', 20 },
                { '25天', 25 },
                { '30天', 30 },
                { '50天', 50 },
                { '100天', 100 },
            } },
            { modid .. '_w_invincible', '光虫无敌', '', true, {
                { '禁用', false },
                { '启用', true },
            } },
            { modid .. '_w_hp', '光虫血量', '调整光虫血量', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '25（原版）', 25 },
                { '50', 50 },
                { '100', 100 },
                { '250', 250 },
                { '500', 500 },
                { '1000', 1000 },
            } },
            { modid .. '_w_regen_hp', '每秒回血量', '调整光虫每秒自动回复最大生命值多少比例的血量', 0, {
                { '禁用', 0 },
                { '1%', 0.01 },
                { '2%', 0.02 },
                { '3%', 0.03 },
                { '4%', 0.04 },
                { '5%', 0.05 },
                { '10%', 0.1 },
                { '25%', 0.25 },
                { '50%', 0.5 },
            } },
            { modid .. '_w_light_range', '光虫光照范围', '调整光虫照明半径', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '1x', 1 },
                { '1.5x', 1.5 },
                { '2x', 2 },
                { '2.5x', 2.5 },
                { '3x', 3 },
                { '4x', 4 },
                { '5x', 5 },
            } },
            { modid .. '_w_max_follow', '最大跟随数量', '调整最多可以有几只光虫跟随玩家', false, {
                { '禁用', false, '若你希望使用其他模组的设定可以选' },
                { '1', 1 },
                { '2', 2 },
                { '3', 3 },
                { '4', 4 },
                { '5', 5 },
                { '6（原版）', 6 },
                { '7', 7 },
                { '8', 8 },
                { '9', 9 },
            } },
        }
    },
    ['en'] = {
        name = 'Better Bulbous Lightbug',
        description = 'For details, please see the mod settings.\n\nCompatible with the following mods:\n- Wormwood Overhaul - Moon Sprout\n- Wormwood Rework ！\n\nCannot adjust Wormwood\'s Lightbug in the "The Value Monster: Wormwood" mod.',
        config = {
            { modid .. '_migrate', 'Lightbugs Follow Through Worlds',
                'Following Lightbugs will travel with you between caves and surface.', true, {
                { 'Disabled', false },
                { 'Enabled',  true },
            } },
            { modid .. '_no_feed', 'No Feeding Required', '', true, {
                { 'Disabled', false },
                { 'Enabled',  true },
            } },
            { modid .. '_invincible', 'Invincible Lightbugs', '', true, {
                { 'Disabled', false },
                { 'Enabled',  true },
            } },
            { modid .. '_hp', 'Lightbug Health', 'Adjust the max health of Lightbugs.', false, {
                { 'Disabled',     false, 'Select this if you want to use settings from other mods.' },
                { '25 (Vanilla)', 25 },
                { '50',           50 },
                { '100',          100 },
                { '250',          250 },
                { '500',          500 },
                { '1000',         1000 },
            } },
            { modid .. '_regen_hp', 'Health Regen Per Second',
                'Adjust the percentage of max health Lightbugs regenerate per second.', 0, {
                { 'Disabled', 0 },
                { '1%',       0.01 },
                { '2%',       0.02 },
                { '3%',       0.03 },
                { '4%',       0.04 },
                { '5%',       0.05 },
                { '10%',      0.1 },
                { '25%',      0.25 },
                { '50%',      0.5 },
            } },
            { modid .. '_light_range', 'Light Radius', 'Adjust the illumination radius of Lightbugs.', false, {
                { 'Disabled', false, 'Select this if you want to use settings from other mods.' },
                { '1x',       1 },
                { '1.5x',     1.5 },
                { '2x',       2 },
                { '2.5x',     2.5 },
                { '3x',       3 },
                { '4x',       4 },
                { '5x',       5 },
            } },
            { modid .. '_max_follow', 'Max Followers', 'Adjust the maximum number of Lightbugs that can follow a player.', false, {
                { 'Disabled',    false, 'Select this if you want to use settings from other mods.' },
                { '1',           1 },
                { '2',           2 },
                { '3 (Vanilla)', 3 },
                { '4',           4 },
                { '5',           5 },
                { '6',           6 },
                { '7',           7 },
                { '8',           8 },
                { '9',           9 },
            } },
            { 'Wormwood\'s Lightbugs' },
            { modid .. '_w_lifetime', 'Lightbug Lifetime', '', 10, {
                { 'Disabled',           false, 'Select this if you want to use settings from other mods.' },
                { '1 Day',              1 },
                { '2 Days',             2 },
                { '2.5 Days (Vanilla)', 2.5 },
                { '5 Days',             5 },
                { '7.5 Days',           7.5 },
                { '10 Days',            10 },
                { '15 Days',            15 },
                { '20 Days',            20 },
                { '25 Days',            25 },
                { '30 Days',            30 },
                { '50 Days',            50 },
                { '100 Days',           100 },
            } },
            { modid .. '_w_invincible', 'Invincible Lightbugs', '', true, {
                { 'Disabled', false },
                { 'Enabled',  true },
            } },
            { modid .. '_w_hp', 'Lightbug Health', 'Adjust the max health of Lightbugs.', false, {
                { 'Disabled',     false, 'Select this if you want to use settings from other mods.' },
                { '25 (Vanilla)', 25 },
                { '50',           50 },
                { '100',          100 },
                { '250',          250 },
                { '500',          500 },
                { '1000',         1000 },
            } },
            { modid .. '_w_regen_hp', 'Health Regen Per Second',
                'Adjust the percentage of max health Lightbugs regenerate per second.', 0, {
                { 'Disabled', 0 },
                { '1%',       0.01 },
                { '2%',       0.02 },
                { '3%',       0.03 },
                { '4%',       0.04 },
                { '5%',       0.05 },
                { '10%',      0.1 },
                { '25%',      0.25 },
                { '50%',      0.5 },
            } },
            { modid .. '_w_light_range', 'Light Radius', 'Adjust the illumination radius of Lightbugs.', false, {
                { 'Disabled', false, 'Select this if you want to use settings from other mods.' },
                { '1x',       1 },
                { '1.5x',     1.5 },
                { '2x',       2 },
                { '2.5x',     2.5 },
                { '3x',       3 },
                { '4x',       4 },
                { '5x',       5 },
            } },
            { modid .. '_w_max_follow', 'Max Followers',
                'Adjust the maximum number of Lightbugs that can follow Wormwood.', false, {
                { 'Disabled',    false, 'Select this if you want to use settings from other mods.' },
                { '1',           1 },
                { '2',           2 },
                { '3',           3 },
                { '4',           4 },
                { '5',           5 },
                { '6 (Vanilla)', 6 },
                { '7',           7 },
                { '8',           8 },
                { '9',           9 },
            } },
        }
    }
}

-- 决定当前用的语言
local cur = (locale == 'zh' or locale == 'zhr' or locale == 'zht') and 'zh' or 'en'

-- mod相关信息
version = '1.2.0'
author = 'Icya'
forumthread = ''
api_version = 10
-- 加载优先级，越低加载越晚，默认为0
priority = -400 -- 月裔萌芽：-20, 沃姆伍德重做：-340
-- 數值怪沃姆伍德：-11111，他自己寫了自己的沃姆伍德光蟲，懶得兼容了

dst_compatible = true                        -- 联机版适配性
dont_starve_compatible = false               -- 单机版适配性
reign_of_giants_compatible = false           -- 单机版：巨人国适配性
-- all_clients_require_mod = true -- 服务端/所有端模组
server_only_mod = true                       -- 仅服务端模组
-- client_only_mod = true -- 仅客户端模组
server_filter_tags = { 'creature', 'tweak' } -- 创意工坊模组分类标签
icon_atlas = 'modicon.xml'                   -- 图集
icon = 'modicon.tex'                         -- 图标

-- 以下自动配置
name = LANGS[cur].name
description = version .. '\n' .. LANGS[cur].description

local config = LANGS[cur].config or {}
local _configuration_options = {}
for i = 1, #config do
    local options = {}
    if config[i][5] then
        for k = 1, #config[i][5] do
            options[k] = { description = config[i][5][k][1], data = config[i][5][k][2], hover = config[i][5][k][3] }
        end
    end
    _configuration_options[i] = {
        name = config[i][1],
        label = config[i][2],
        hover = config[i][3] or '',
        default = config[i][4] or false,
        options = #options > 0 and options or { { description = "", data = false } },
    }
end

configuration_options = _configuration_options
