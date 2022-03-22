local fn = vim.fn

local config = {
	filetype = {
		rust = {
			-- Rustfmt
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout", "--config-path ~/.config/rustfmt/rustfmt.toml" },
					stdin = true,
				}
			end,
		},
		go = {
			-- gofmt
			function()
				return {
					exe = "gofmt",
					args = {},
					stdin = true,
				}
			end,
		},
		javascript = {
			-- Prettier
			function()
				return {
					exe = "npx prettier",
					args = {
						"--stdin-filepath",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
						"--print-width",
						100,
						"--tab-width",
						4,
						"--config-precedence",
						"prefer-file",
					},
					stdin = true,
				}
			end,
		},
		python = {
			-- black
			function()
				return {
					exe = "black",
					args = {},
					stdin = false,
				}
			end,
		},
		solidity = {
			-- Prettier
			function()
				return {
					exe = "npx prettier",
					args = {
						"--stdin-filepath",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
						"--print-width",
						100,
						"--tab-width",
						4,
						"--config-precedence",
						"prefer-file",
					},
					cwd = fn.expand("$HOME"),
					stdin = true,
				}
			end,
		},
		lua = {
			-- luafmt
			function()
				return {
					exe = "stylua",
					args = {
						"--column-width",
						100,
						"--indent-type",
						"Spaces",
					},
					stdin = false,
				}
			end,
		},
		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = "shfmt",
					args = { "-i", 4 },
					stdin = true,
				}
			end,
		},
		json = {
			-- Prettier
			function()
				return {
					exe = "npx prettier",
					args = {
						"--stdin-filepath",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
						"--print-width",
						100,
						"--tab-width",
						4,
					},
					stdin = true,
				}
			end,
		},
	},
}

require("formatter").setup(config)

-- Format on save
vim.api.nvim_exec(
	[[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.rs,*.go,*.ts,*.js,*.py,*sol,*.lua,*.sh,*.json FormatWrite
        augroup END
    ]],
	true
)
