-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    -- {
    --   "Mofiqul/dracula.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   init = function()
    --     require("dracula").setup {
    --     }
    --     vim.cmd [[colorscheme dracula]]
    --   end
    -- },
    -- {
    --   "catppuccin/nvim",
    --   name = "catppuccin",
    --   priority = 1000,
    --   init = function()
    --     vim.cmd [[colorscheme catppuccin]]
    --   end
    -- },
    {
      'eddyekofo94/gruvbox-flat.nvim',
      priority = 1000,
      enabled = true,
      init = function()
        vim.cmd [[colorscheme gruvbox-flat]]
      end,
    },
    {
      'xiyaowong/transparent.nvim',
      name = 'transparent',
      init = function()
        print("Calling this this")
        require('transparent').toggle(true)
      end,
      opts = {
        exclude_groups = {
          "LspFloatWinNormal",
          "NormalFloat",
          "FloatBorder",
          "TelescopeNormal",
          "TelescopeBorder",
          "TelescopePromptBorder",
          "SagaBorder",
          "SagaNormal",
        }
      },
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {},
  -- automatically check for plugin updates
  checker = { enabled = false },
})
