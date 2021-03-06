-------------------------------------------------------------------------------
--[Renamer]--
-------------------------------------------------------------------------------
local Data = require('stdlib/data/data')

Data {type = 'custom-input', name = 'picker-rename', key_sequence = 'CONTROL + R', consuming = 'all'}
Data {type = 'font', name = 'picker-rename-button', from = 'default-bold', size = 14}

Data.Util.extend_style {
    type = 'button_style',
    name = 'picker-rename-button',
    parent = 'button',
    font = 'picker-rename-button',
    align = 'center',
    top_padding = 2,
    right_padding = 2,
    bottom_padding = 2,
    left_padding = 2,
    default_font_color = {r = 1, g = 0.707, b = 0.12},
    hovered_font_color = {r = 1, g = 1, b = 1},
    clicked_font_color = {r = 1, g = 0.707, b = 0.12}
}
