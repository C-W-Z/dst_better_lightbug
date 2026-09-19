---@diagnostic disable: lowercase-global, undefined-global, trailing-space
-- 本地化
local op = { { 'A', 97 }, { 'B', 98 }, { 'C', 99 }, { 'D', 100 }, { 'E', 101 }, { 'F', 102 }, { 'G', 103 }, { 'H', 104 }, { 'I', 105 }, { 'J', 106 }, { 'K', 107 }, { 'L', 108 }, { 'M', 109 }, { 'N', 110 }, { 'O', 111 }, { 'P', 112 }, { 'Q', 113 }, { 'R', 114 }, { 'S', 115 }, { 'T', 116 }, { 'U', 117 }, { 'V', 118 }, { 'W', 119 }, { 'X', 120 }, { 'Y', 121 }, { 'Z', 122 }, { '0', 48 }, { '1', 49 }, { '2', 50 }, { '3', 51 }, { '4', 52 }, { '5', 53 }, { '6', 54 }, { '7', 55 }, { '8', 56 }, { '9', 57 } }

local modid = 'betterlb'
local LANGS = {
    ['zh'] = {
        name = '更好的球状光虫',
        description = '详细功能请查看模组设置',
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
            { modid .. '_hp', '光虫血量', '调整光虫血量', 25, {
                { '禁用', false, '若你希望使用其他模組的光蟲血量可以選這個' },
                { '25（原版）', 25 },
                { '50', 50 },
                { '100', 100 },
                { '250', 250 },
                { '500', 500 },
                { '1000', 1000 },
            } },
            { modid .. '_regen_hp', '每秒回血量', '调整光虫每秒自動回復最大生命值多少比例的血量', 0, {
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
            { modid .. '_light_range', '光虫光照范围', '调整光虫照明半径', 1, {
                { '禁用', false, '若你希望使用其他模組的光照范围可以選這個' },
                { '1x', 1 },
                { '1.5x', 1.5 },
                { '2x', 2 },
                { '2.5x', 2.5 },
                { '3x', 3 },
                { '4x', 4 },
                { '5x', 5 },
            } },
            { modid .. '_max_follow', '最大跟隨數量', '调整最多可以有幾隻光蟲跟隨玩家', 3, {
                { '禁用', false, '若你希望使用其他模組的跟隨數量可以選這個' },
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
            -- { modid .. '_wander_range', '野生光蟲遊蕩範圍', '调整野生光蟲遊蕩半徑', 10, {
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
            { modid .. '_w_lifetime', '光虫存活時間', '', true, {
                { '禁用', false, '若你希望使用其他模組的存活時間可以選這個' },
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
            { modid .. '_w_hp', '光虫血量', '調整光虫血量', 25, {
                { '禁用', false, '若你希望使用其他模組的光蟲血量可以選這個' },
                { '25（原版）', 25 },
                { '50', 50 },
                { '100', 100 },
                { '250', 250 },
                { '500', 500 },
                { '1000', 1000 },
            } },
            { modid .. '_w_regen_hp', '每秒回血量', '调整光虫每秒自動回復最大生命值多少比例的血量', 0, {
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
            { modid .. '_w_light_range', '光虫光照范围', '调整光虫照明半径', 1, {
                { '禁用', false, '若你希望使用其他模組的光照范围可以選這個' },
                { '1x', 1 },
                { '1.5x', 1.5 },
                { '2x', 2 },
                { '2.5x', 2.5 },
                { '3x', 3 },
                { '4x', 4 },
                { '5x', 5 },
            } },
            { modid .. '_w_max_follow', '最大跟隨數量', '调整最多可以有幾隻光蟲跟隨玩家', 3, {
                { '禁用', false, '若你希望使用其他模組的跟隨數量可以選這個' },
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
        description = 'For details, please see the mod settings.',
        config = {
            -- { 'LANGUAGE' },
            -- { modid .. '_lang', 'language', 'choose language', 'en', {
            --     { '简体中文', 'cn' },
            --     { 'English', 'en' }
            -- } },
            -- { 'FUNCTIONS' },
            { modid .. '_migrate', 'Lightbug Caves Migration',
                'Following Lightbugs will travel with you between caves and surface', true, {
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
            { modid .. '_hp', 'Lightbug Health', 'Adjust Lightbug max health', 25, {
                { '25 (Vanilla)', 25 },
                { '50',           50 },
                { '100',          100 },
                { '250',          250 },
                { '500',          500 },
                { '1000',         1000 },
            } },
            { modid .. '_regen_hp', 'Health Regen per second',
                'Adjust the percentage of maximum health that Lightbugs automatically regenerate per second', 0, {
                { '0% (Vanilla)', 0 },
                { '1%',           0.01 },
                { '2%',           0.02 },
                { '3%',           0.03 },
                { '4%',           0.04 },
                { '5%',           0.05 },
                { '10%',          0.1 },
                { '25%',          0.25 },
                { '50%',          0.5 },
            } },
            { modid .. '_light_range', 'Light Radius Multiplier', 'Adjust Lightbug light radius', 1, {
                { '1x',   1 },
                { '1.5x', 1.5 },
                { '2x',   2 },
                { '2.5x', 2.5 },
                { '3x',   3 },
                { '4x',   4 },
                { '5x',   5 },
            } },
            { modid .. '_max_follow', 'Maximum Following Lightbugs',
                'Adjust the maximum number of Lightbugs that can follow you', 3, {
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
priority = -100                              -- 月裔萌芽：-20, 數值怪沃姆伍德：, 沃姆伍德重做：

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
            options[k] = { description = config[i][5][k][1], data = config[i][5][k][2] }
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
