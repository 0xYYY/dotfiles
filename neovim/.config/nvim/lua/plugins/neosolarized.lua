local n = require("neosolarized").setup({
    comment_italics = true,
kkground_set = true,background_set = true,kground_set = true,background_set = true,background_set = true,kground_set = true,background_set = true,background_set = true,ground_set = true,
})

-- nvim-cmp
n.Group.new("Pmenu", n.colors.base1, n.colors.base02)
n.Group.new("PmenuSel", n.colors.base03, n.colors.yellow, n.styles.bold)
n.Group.new("PmenuSbar", n.colors.cyan, n.colors.base02)
n.Group.new("PmenuThumb", n.colors.cyan, n.colors.base02)
n.Group.new("CmpItemAbbr", n.colors.base1, n.colors.base02)
n.Group.new("CmpItemKind", n.colors.cyan, n.colors.base02)
n.Group.new("CmpItemMenu", n.colors.cyan, n.colors.base02)
n.Group.new("CmpItemAbbrMatch", n.colors.red, n.colors.base02)
n.Group.new("CmpItemAbbrMatchFuzzy", n.colors.red, n.colors.base02)

-- -- telescope
n.Group.new("TelescopeBorder", n.colors.base1)
n.Group.new("TelescopePromptBorder", n.colors.base1)
n.Group.new("TelescopeResultsBorder", n.colors.base1)
n.Group.new("TelescopePreviewBorder", n.colors.base1)
n.Group.new("TelescopeMatching", n.colors.red)
n.Group.new("TelescopeSelection", n.colors.base00, n.colors.base02, n.styles.bold)
n.Group.new("TelescopeSelection", n.colors.base00, n.colors.base02, n.styles.bold)
n.Group.new("TelescopeSelection", n.colors.base00, n.colors.base02, n.styles.bold)
n.Group.new("CmpItemKind", n.colors.cyan, n.colors.base02)
n.Group.new("CmpItemMenu", n.colors.cyan, n.colors.base02)
n.Group.new("CmpItemAbbrMatch", n.colors.red, n.colors.base02)
n.Group.new("CmpItemAbbrMatchFuzzy", n.colors.red, n.colors.base02)
