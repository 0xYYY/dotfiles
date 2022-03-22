local cmd = vim.cmd
local fn = vim.fn
local colors = require("colors")
local gl = require("galaxyline")
local fileinfo = require("galaxyline.providers.fileinfo")
local condition = require("galaxyline.condition")
local section = gl.section

local function all(conditions)
	return function()
		for _, cond in pairs(conditions) do
			if not cond() then
				return false
			end
		end
		return true
	end
end

local function check_width()
	return vim.fn.winwidth(0) > 100
end

-- Left section
section.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				n = colors.blue,
				i = colors.yellow,
				v = colors.magenta,
				[""] = colors.magenta,
				V = colors.magenta,
				c = colors.base1,
				no = colors.magenta,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.purple,
				Rv = colors.purple,
				cv = colors.base1,
				ce = colors.base1,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.base1,
				t = colors.base1,
			}
			local mode_text = {
				n = "NOR",
				i = "INS",
				v = "VIS",
				[""] = "VIS",
				V = "VIS",
				c = "COM",
				no = "???",
				s = "???",
				S = "???",
				[""] = "???",
				ic = "???",
				R = "???",
				Rv = "???",
				cv = "COM",
				ce = "COM",
				r = "???",
				rm = "???",
				["r?"] = "???",
				["!"] = "COM",
				t = "COM",
			}
			cmd("hi GalaxyViMode guibg=" .. mode_color[fn.mode()])
			return "  " .. mode_text[fn.mode()] .. " "
		end,
		separator = " ",
		highlight = { colors.base3, colors.base03, "bold" },
	},
}

local custom_file_icons = fileinfo.define_file_icon()
custom_file_icons["solidity"] = { "#81A8F8", "ﲹ" }
custom_file_icons["sol"] = { "#81A8F8", "ﲹ" }

section.left[2] = {
	FileIcon = {
		condition = condition.buffer_not_empty,
		provider = "FileIcon",
		highlight = { fileinfo.get_file_icon_color },
	},
}

section.left[3] = {
	FileName = {
		condition = condition.buffer_not_empty,
		provider = function()
			local file = fn.expand("%:t")
			local icon = ""
			if vim.bo.readonly then
				icon = " "
			elseif vim.bo.modifiable and vim.bo.modified then
				icon = " "
			end
			return file .. icon
		end,
		--[[ provider = function()
          return fn.expand("%:F")
        end, ]]
		separator = "  ",
		highlight = { colors.base1, colors.base03, "bold" },
	},
}

section.left[4] = {
	LSP = {
		condition = all({ check_width, condition.check_active_lsp }),
		provider = "GetLspClient",
		icon = "突",
		separator = " ",
		highlight = { fileinfo.get_file_icon_color },
	},
}
section.left[5] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = " ",
		highlight = { colors.cyan },
	},
}

section.left[6] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = " ",
		highlight = { colors.blue },
	},
}

section.left[7] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = " ",
		highlight = { colors.yellow },
	},
}

section.left[8] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = " ",
		highlight = { colors.red },
	},
}

-- Right section
section.right[1] = {
	DiffAdd = {
		provider = "DiffAdd",
		icon = " ",
		separator = " ",
		highlight = { colors.green },
	},
}

section.right[2] = {
	DiffModified = {
		provider = "DiffModified",
		icon = " ",
		highlight = { colors.yellow },
	},
}

section.right[3] = {
	DiffRemove = {
		provider = "DiffRemove",
		icon = " ",
		highlight = { colors.red },
	},
}

section.right[4] = {
	GitBranch = {
		condition = condition.check_git_workspace,
		provider = "GitBranch",
		icon = "",
		highlight = { colors.cyan, "none", "bold" },
	},
}

section.right[5] = {
	FileEncode = {
		condition = all({ condition.buffer_not_empty, check_width }),
		provider = "FileEncode",
		separator = " ",
	},
}

section.right[6] = {
	FileFormat = {
		condition = all({ condition.buffer_not_empty, check_width }),
		provider = function()
			local format_map = {
				UNIX = "",
				MAC = "",
				DOS = "",
			}
			local format = string.gsub(fileinfo.get_file_format(), "%s+", "")
			return format_map[format] .. " "
		end,
		separator = " ",
	},
}

local function current_line_percent()
	local current_line = vim.fn.line(".")
	local total_line = vim.fn.line("$")
	if current_line == 1 then
		return "TOP"
	elseif current_line == vim.fn.line("$") then
		return "BOT"
	end
	local result, _ = math.modf((current_line / total_line) * 100)
	return result .. "%"
end

section.right[7] = {
	LineInfo = {
		condition = all({ condition.buffer_not_empty, check_width }),
		-- condition = check_width,
		provider = function()
			local current_line_percent = current_line_percent()
			local total_line = fn.line("$")
			--[[ local line_column = string.format("%3d:%2d ", vim.fn.line('.'), vim.fn.col('.'))
        return "☰ "..current_line_percent.."/"..total_line.."  "..line_column ]]
			return "☰ " .. current_line_percent .. "/" .. total_line .. " "
		end,
		separator = " ",
		highlight = { colors.base2, colors.base1, "bold" },
		separator_highlight = { colors.base2, colors.base1, "bold" },
	},
}

-- Short line
gl.short_line_list = { "LuaTree", "CHADTree", "NvimTree" }

section.short_line_left[1] = {
	SFileName = {
		condition = condition.buffer_not_empty,
		provider = function()
			local fname = fileinfo.get_current_file_name()
			for _, v in ipairs(gl.short_line_list) do
				if v == vim.bo.filetype then
					return ""
				end
			end
			return fname
		end,
	},
}

section.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
	},
}

--[[ local buf_icon = {
  help             = '  ',
  defx             = '  ',
  nerdtree         = '  ',
  denite           = '  ',
  ['vim-plug']     = '  ',
  vista            = ' 識',
  vista_kind       = '  ',
  dbui             = '  ',
  magit            = '  ',
  NvimTree          = '  ',
} ]]
