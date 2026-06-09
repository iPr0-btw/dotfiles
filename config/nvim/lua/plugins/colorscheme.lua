return {
  -- add onedark
  { "olimorris/onedark.nvim" },
  -- { "tiagovla/tokyodark.nvim" },

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark_dark",
    },
  },
}
