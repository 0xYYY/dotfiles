-- Theme
local colors = require("colors")
local solarized_dark = require("lualine.themes.solarized_dark")
solarized_dark.normal.c.bg = colors.base03
solarized_dark.normal.b.bg = colors.base02
solarized_dark.normal.b.fg = colors.base1
solarized_dark.insert.a.bg = colors.yellow
solarized_dark.command = { a = { fg = colors.base03, bg = colors.cyan, gui = "bold" } }

-- LSP component (null-ls sources extracted)
local null_ls_sources = function()
	local ft = vim.bo.filetype
	local client_names = {}
	for i, s in ipairs(require("null-ls").get_sources()) do
		if s.filetypes[ft] then
			table.insert(client_names, s.name)
		end
	end

	return client_names
end

local lspclient = {
	function()
		local clients = vim.lsp.buf_get_clients()
		local client_names = {}
		for _, client in pairs(clients) do
			if client.name == "null-ls" then
				vim.list_extend(client_names, null_ls_sources())
			else
				table.insert(client_names, client.name)
			end
		end

		local first_few = vim.list_slice(client_names, 1, 2)
		local extra_count = #client_names - 2
		local output = table.concat(first_few, "")
		if extra_count > 0 then
			output = output .. " +" .. extra_count
		end
		return output
	end,
	cond = function()
		return #vim.lsp.buf_get_clients() > 0
	end,
	icons_enabled = true,
	icon = "",
	color = function(section)
		local f_name, f_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
		local icon, color = require("nvim-web-devicons").get_icon_color(f_name, f_ext)
		return { fg = color }
	end,
}

-- local lspprogress = {
-- 	"lsp_progress",
-- 	display_components = { "spinner", { "title", "percentage", "message" } },
-- 	colors = {
-- 		percentage = colors.blue,
-- 		title = colors.blue,
-- 		message = colors.base1,
-- 		spinner = colors.blue,
-- 		lsp_client_name = colors.magenta,
-- 		use = true,
-- 	},
-- 	timer = { progress_enddelay = 100, spinner = 100, lsp_client_name_enddelay = 100 },
-- 	spinner_symbols = {
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 		" ",
-- 	},
-- }

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = solarized_dark,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = { "NvimTree", "Outline" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function(str)
				return str:sub(1, 3)
			end,
		} },
		lualine_b = {
			{ "branch", icon = "" },
			{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
		},
		lualine_c = { lspclient, "diagnostics" },
		lualine_x = { "encoding", "fileformat", { "filetype", icon_only = true } },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
