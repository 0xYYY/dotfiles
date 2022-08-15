require("fidget").setup({
	text = {
		spinner = "square_corners", -- animation shown when tasks are ongoing
		done = " ", -- character shown when all tasks are complete
		commenced = "Started", -- message shown when task starts
		completed = "Completed", -- message shown when task completes
	},
	window = {
		relative = "win", -- where to anchor, either "win" or "editor"
		blend = 50, -- &winblend for the window
		zindex = nil, -- the zindex value for the window
	},
	fmt = {
		leftpad = true, -- right-justify text in fidget box
		stack_upwards = true, -- list of tasks grows upwards
		max_width = 0, -- maximum width of the fidget box
		-- function to format fidget title
		fidget = function(fidget_name, spinner)
			return string.format("%s %s", spinner, fidget_name)
		end,
		-- function to format each task line
		task = function(task_name, message, percentage)
			local function notempty(s)
				return s ~= nil and s ~= ""
			end
			return string.format(
				"%s%s%s",
				notempty(task_name) and string.format("[%s] ", task_name) or "",
				notempty(message) and string.format("%s ", message) or "",
				notempty(percentage) and string.format("(%s%%)", percentage) or ""
			)
		end,
	},
})
