---@diagnostic disable: lowercase-global, undefined-global, trailing-space
-- 本地化
local op = { { 'A', 97 }, { 'B', 98 }, { 'C', 99 }, { 'D', 100 }, { 'E', 101 }, { 'F', 102 }, { 'G', 103 }, { 'H', 104 }, { 'I', 105 }, { 'J', 106 }, { 'K', 107 }, { 'L', 108 }, { 'M', 109 }, { 'N', 110 }, { 'O', 111 }, { 'P', 112 }, { 'Q', 113 }, { 'R', 114 }, { 'S', 115 }, { 'T', 116 }, { 'U', 117 }, { 'V', 118 }, { 'W', 119 }, { 'X', 120 }, { 'Y', 121 }, { 'Z', 122 }, { '0', 48 }, { '1', 49 }, { '2', 50 }, { '3', 51 }, { '4', 52 }, { '5', 53 }, { '6', 54 }, { '7', 55 }, { '8', 56 }, { '9', 57 } }

local modid = 'betterlb'
local LANGS = {
    ['zh'] = {
        name = '更好的球狀光蟲',
        description = '模板',
        config = {
            -- {'设置的id','设置的名称','聚焦时显示的提示',默认值,{
            --     {选项一,值},
            --     {选项二,值}
            -- }},
            { '语言' },
            { modid .. '_lang', '语言', '语言', 'cn', {
                { '简体中文', 'cn' },
                { 'English', 'en' }
            } },
            { '功能' },
            { modid .. '_no_feed', '光蟲無需餵食', '', true, {
                { '禁用', false },
                { '啟用', true },
            } },
            { modid .. '_invincible', '光蟲無敵', '', true, {
                { '禁用', false },
                { '啟用', true },
            } },
            { modid .. '_hp', '光蟲血量', '调整光蟲血量', 25, {
                { '25（原版）', 25 },
                { '50', 50 },
                { '100', 100 },
                { '250', 250 },
                { '500', 500 },
                { '1000', 1000 },
            } },
            { modid .. '_light_range', '光蟲光照半徑', '调整光蟲照明半徑', 1, {
                { '1x',   1 },
                { '1.5x', 1.5 },
                { '2x',   2 },
                { '2.5x', 2.5 },
                { '3x',   3 },
            } },
            -- { modid .. '_intensity', '光蟲亮度', '调整光蟲亮度', 0.5, {
            --     { '0.5（原版）', 0.5 },
            --     { '0.6', 0.6 },
            --     { '0.7', 0.7 },
            --     { '0.8', 0.8 },
            --     { '0.9', 0.9 },
            --     { '1.0', 1 },
            -- } },
        }
    },
    ['en'] = {
        name = 'Better Bulbous Lightbug',
        description = 'Template',
        config = {
            { 'LANGUAGE' },
            { modid .. '_lang', 'language', 'choose language', 'en', {
                { '简体中文', 'cn' },
                { 'English', 'en' }
            } },
            { 'FUNCTIONS' },
            -- {modid..'_dmgmult','Damage Mult','Damage Mult Settings',{
            --     {'x0.5',0.5},
            --     {'x1',1},
            --     {'x2',2}
            -- }}
        }
    }
}

-- 决定当前用的语言
local cur = (locale == 'zh' or locale == 'zhr') and 'zh' or 'en'

-- mod相关信息
version = '1.0.0'
author = 'Icya'
forumthread = ''
api_version = 10
priority = 0                        -- 加载优先级，越低加载越晚，默认为0

dst_compatible = true               -- 联机版适配性
dont_starve_compatible = false      -- 单机版适配性
reign_of_giants_compatible = false  -- 单机版：巨人国适配性
-- all_clients_require_mod = true -- 服务端/所有端模组
server_only_mod = true              -- 仅服务端模组
-- client_only_mod = true -- 仅客户端模组
server_filter_tags = { 'creature' } -- 创意工坊模组分类标签
icon_atlas = 'modicon.xml'          -- 图集
icon = 'modicon.tex'                -- 图标

-- 以下自动配置
name = LANGS[cur].name
description = version .. '\n' .. LANGS[cur].description

-- local op = {
--     {description='A', data = 97},
--     {description='B', data = 98},
--     {description='C', data = 99},
--     {description='D', data = 100},
--     {description='E', data = 101},
--     {description='F', data = 102},
--     {description='G', data = 103},
--     {description='H', data = 104},
--     {description='I', data = 105},
--     {description='J', data = 106},
--     {description='K', data = 107},
--     {description='L', data = 108},
--     {description='M', data = 109},
--     {description='N', data = 110},
--     {description='O', data = 111},
--     {description='P', data = 112},
--     {description='Q', data = 113},
--     {description='R', data = 114},
--     {description='S', data = 115},
--     {description='T', data = 116},
--     {description='U', data = 117},
--     {description='V', data = 118},
--     {description='W', data = 119},
--     {description='X', data = 120},
--     {description='Y', data = 121},
--     {description='Z', data = 122},

--     {description='0', data = 48},
--     {description='1', data = 49},
--     {description='2', data = 50},
--     {description='3', data = 51},
--     {description='4', data = 52},
--     {description='5', data = 53},
--     {description='6', data = 54},
--     {description='7', data = 55},
--     {description='8', data = 56},
--     {description='9', data = 57},
-- }

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
