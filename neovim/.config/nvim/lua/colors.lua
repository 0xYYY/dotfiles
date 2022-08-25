local M = {}

-- Solarized Dark
M.base03 = "#002b36"
M.base02 = "#073642"
M.base01 = "#586e75"
M.base00 = "#657b83"
M.base0 = "#839496"
M.base1 = "#93a1a1"
M.base2 = "#eee8d5"
M.base3 = "#fdf6e3"
M.yellow = "#b58900"
M.orange = "#cb4b16"
M.red = "#dc322f"
M.magenta = "#d33682"
M.violet = "#6c71c4"
M.blue = "#268bd2"
M.cyan = "#2aa198"
M.green = "#859900"

-- The following utility functions are copied from tokyonight.nvim: https://github.com/folke/tokyonight.nvim/blob/8223c970677e4d88c9b6b6d81bda23daf11062bb/lua/tokyonight/util.lua

local function hexToRgb(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local r, g, b = string.match(hex_str, pat)
	return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(fg, bg, alpha)
	bg = hexToRgb(bg)
	fg = hexToRgb(fg)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
	return M.blend(hex, bg or M.base03, math.abs(amount))
end

return M
