local carbon = require("carbon-now")
carbon.setup({
	open_cmd = "open",
	options = {
		theme = "solarized dark",
		window_theme = "none",
		font_family = "JetBrains Mono",
		font_size = "16px",
		bg = "#2aa198",
		line_numbers = false,
		line_height = "133%",
		drop_shadow = false,
		drop_shadow_offset_y = "16px",
		drop_shadow_blur = "64px",
		width = "640",
		watermark = false,
	},
})
