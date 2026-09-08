---@diagnostic disable: lowercase-global, undefined-global, trailing-space

local modid = 'betterlb'

local data = _require('core_'..modid..'/data/keyhandlers')

API.KEYHANDLER:main(data)