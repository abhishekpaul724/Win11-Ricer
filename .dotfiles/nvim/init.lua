vim.opt.fileformats = "unix,dos"
vim.opt.number = true
vim.opt.relativenumber = true
vim.keymap.set("n", "<leader>ef", ":NvimTreeFocus<CR>", { desc = "Focus Nvim-Tree" })
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { 
  noremap = true, 
  silent = true, 
  desc = "Toggle Nvim-Tree" 
})
-- Set indentation to 4 spaces
vim.opt.tabstop = 4          -- Width of a tab character (display)
vim.opt.shiftwidth = 4       -- Number of spaces to use for each indent level
vim.opt.expandtab = true     -- Insert spaces instead of tab characters
vim.opt.smartindent = true   -- Enable smart auto-indentation (e.g., after { and })   
vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR }, -- Only show errors, not warnings
      },
  signs = true,
  float = { source = true }
})   
require("config.lazy")
