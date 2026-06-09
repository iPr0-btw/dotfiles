-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
vim.cmd("set wrap")

vim.api.nvim_create_autocmd("TextChanged", {
  group = vim.api.nvim_create_augroup("autosave", { clear = true }),
  pattern = "*",
  command = "silent write",
})

vim.api.nvim_create_autocmd("TextChangedI", {
  group = "autosave",
  pattern = "*",
  command = "silent write",
})

-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
