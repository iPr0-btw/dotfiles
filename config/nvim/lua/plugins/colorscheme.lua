-- eturn {
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
-- lua/plugins/colorscheme.lua
return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
        on_highlights = function(hl)
          hl.Normal = { bg = "#000000", fg = "#c0caf5" }
          hl.NormalSB = { bg = "#000000", fg = "#c0caf5" }
          hl.CursorLine = { bg = "#15161e" }
          hl.LineNr = { fg = "#414868" }
          hl.Visual = { bg = "#283457" }
          hl.Pmenu = { bg = "#15161e" }
          hl.PmenuSel = { fg = "#000000", bg = "#7aa2f7" }
          hl.Comment = { fg = "#EDACC2", italic = true } -- Add this line
          -- add more overrides
        end,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
