local colors = {
  bg = "#000000",
  fg = "#c0caf5",
  bg_dark = "#15161e",
  bg_darker = "#292e42",
  blue = "#7aa2f7",
  purple = "#bb9af7",
  green = "#9ece6a",
  red = "#f7768e",
  yellow = "#e0af68",
  cyan = "#7dcfff",
  orange = "#ff9e64",
  gray = "#545c7e",
  gray_dark = "#414868",
  pink = "#EDACC2",
}

vim.g.colors_name = "tokyo-night-oled"
vim.o.background = "dark"

-- Define all your highlights
local groups = {
  Normal = { bg = colors.bg, fg = colors.fg },
  NormalFloat = { bg = colors.bg_dark, fg = colors.fg },
  Comment = { fg = colors.pink, italic = true },
  String = { fg = colors.green },
  Function = { fg = colors.blue, bold = true },
  Keyword = { fg = colors.purple },
  Type = { fg = colors.cyan },
  Constant = { fg = colors.orange },
  StatusLine = { bg = colors.bg, fg = colors.bg },
  -- Add more as needed
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
