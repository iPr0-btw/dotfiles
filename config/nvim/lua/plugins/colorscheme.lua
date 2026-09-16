-- return {
--  -- add onedark
--  { "olimorris/onedark.nvim" },
--  -- { "tiagovla/tokyodark.nvim" },
-- 
--  -- Configure LazyVim to load onedark
--  {
--    "LazyVim/LazyVim",
--    opts = {
--      colorscheme = "onedark_dark",
--    },
--  },
-- 
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      on_highlights = function(hl, c)
        -- Override with your OLED colors
        hl.Normal = { bg = "#000000", fg = "#c0caf5" }
        hl.NormalSB = { bg = "#000000", fg = "#c0caf5" }
        hl.NormalFloat = { bg = "#15161e", fg = "#c0caf5" }
        hl.FloatBorder = { fg = "#414868", bg = "#15161e" }
        hl.CursorLine = { bg = "#15161e" }
        hl.LineNr = { fg = "#414868" }
        hl.Comment = { fg = "#545c7e" }
        hl.String = { fg = "#9ece6a" }
        hl.Function = { fg = "#7aa2f7" }
        hl.Keyword = { fg = "#bb9af7" }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}

