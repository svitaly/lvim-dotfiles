-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require("lvim.lsp.manager").setup("marksman")

-- PLUGINS
lvim.plugins = {
  "AckslD/nvim-trevJ.lua",
  "tpope/vim-surround",
-- github colorscheme config
  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })
      vim.cmd('colorscheme github_dark')
    end,
  }
}

-- OPTIONS
lvim.reload_config_on_save = true
vim.opt.relativenumber = true -- relative line numbers
vim.opt.showmode = true       -- relative line numbers
vim.opt.timeoutlen = 500
-- vim.opt.guicursor = "i-n-v-c-sm-ci-ve-r-cr-o:block,a:blinkon50"
vim.opt.clipboard = ""
vim.opt_global.clipboard = ""
vim.opt.showcmd = true
vim.opt.colorcolumn= "81"
vim.opt.wrap = false
vim.opt.spell = false
lvim.builtin.treesitter.ensure_installed = "all" -- automatically install syntax highlighting for all languages
lvim.colorscheme = "github_dark_high_contrast"
lvim.builtin.alpha.dashboard.section.header.val = {"", "", "", "", "Life sucks - get a helmet!", "", ""}

-- KEYMAPS
-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local keyopts = { remap = false, silent = true }
vim.g.maplocalleader = ','

-- Normal --
keymap("n", "<LocalLeader>c", ":BufferKill<cr>", keyopts)
keymap("n", "<LocalLeader>j", ":lua require('trevj').format_at_cursor()<CR>", keyopts)
keymap("n", "<S-h>", ":bprev<CR>", keyopts)
keymap("n", "<S-l>", ":bnext<CR>", keyopts)
-- pipe operator accesses system clipboard
-- keymap({"v","n"}, "|", '"+', keyopts)
-- single press indent
keymap("n", ">", ">>", keyopts)
keymap("n", "<", "<<", keyopts)
keymap("n", "A-j", "<Esc>:m .+1<CR>==", keyopts)
keymap("n", "A-k", "<Esc>:m .-2<CR>==", keyopts)
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", keyopts)
keymap("v", ">", ">gv", keyopts)
-- Visual Block --
keymap("x", "A-j", ":move '>+1<CR>gv-gv", keyopts)
keymap("x", "A-k", ":move '<-2<CR>gv-gv", keyopts)

-- AUTOCOMMANDS
-- SETUP
-- lvim.builtin.nvimtree.setup.open_on_tab = true
-- lvim.builtin.nvimtree.setup.trash = {
--   cmd = "gio trash",
--   require_confirm = true,
-- }
-- lvim.builtin.nvimtree.setup.view.relativenumber = true
local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings.i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
}

-- WHICH_KEY
local which_key = lvim.builtin.which_key

which_key.setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true,    -- adds help for operators like d, y, ...
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  }
}
which_key.mappings["w"] = {
  name = "Window",
  h = { "<cmd>split<CR>", "Split Horizontal" },
  v = { "<cmd>vsplit<CR>", "Split Vertical" },
  c = { "<cmd>close<CR>", "Close Window" },
}

which_key.mappings["t"] = {
  name = "Tabs",
  n = { "<cmd>tabnew<CR>", "New Tab" },
  c = { "<cmd>tabclose<CR>", "Close Tab" },
}

-- which_key.mappings.s.name = 'Find'

-- which_key.mappings["f"] = which_key.mappings["s"]

-- which_key.mappings["s"] = {}

-- which_key.mappings["c"] = {
--   name = "My Commands",
--   o = { "<cmd>MkOpenSrc<CR>", "Open Src File" },
-- }
