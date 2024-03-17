-- Copyright (c) 2021-2022 tiagovla
-- License: MIT
--
local p = require("neodarker.palette")
local colors = {
    bg = p.bg1,
    bg6 = p.bg6,
    fg = p.fg,
    red = p.red,
    green = p.green,
    yellow = p.yellow,
    blue = p.blue,
    purple = p.purple,
    cyan = p.cyan,
    grey = p.grey,
}

local neo_darker = {
    inactive = {
        a = { fg = colors.grey, bg = colors.bg, gui = "bold" },
        b = { fg = colors.grey, bg = colors.bg },
        c = { fg = colors.grey, bg = colors.bg },
        x = { fg = colors.grey, bg = colors.bg },
        y = { fg = colors.grey, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg, gui = "bold" },
    },
    normal = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.green, bg = colors.bg6 },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.green, bg = colors.bg6 },
        z = { fg = colors.bg, bg = colors.green, gui = "bold" },
    },
    visual = {
        a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
        b = { fg = colors.purple },
    },
    replace = {
        a = { fg = colors.bg, bg = colors.red, gui = "bold" },
        b = { fg = colors.red },
    },
    insert = {
        a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
        b = { fg = colors.blue },
    },
    command = {
        a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.yellow },
    },
}

local mt = {}
function mt:__index(k)
    if k == "colors" then
        return colors
    end
end

neo_darker = setmetatable(neo_darker, mt)

return neo_darker
