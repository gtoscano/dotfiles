local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  use 'ellisonleao/gruvbox.nvim'
  use 'dracula/vim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'bluz71/vim-nightfly-colors'
  use 'vim-test/vim-test'
  use 'lewis6991/gitsigns.nvim'
  use 'preservim/vimux'
  --use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'

  -- rust babyyyyyyy
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'simrat39/rust-tools.nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use 'mattn/emmet-vim'
  use {
    'prettier/vim-prettier',
    run = 'yarn install --frozen-lockfile --production',
    ft = {'html', 'javascript', 'css', 'json', 'markdown', 'typescript'},
    --config = function()
    --  vim.cmd[[let g:prettier#autoformat = 0]]
    --  vim.cmd[[let g:prettier#autoformat_require_pragma = 0]]
    --end
  }
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  }
  use "glepnir/lspsaga.nvim"
  use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
  use 'nvim-neotest/nvim-nio'

-- vimspector
use {
  "puremourning/vimspector",
  cmd = { "VimspectorInstall", "VimspectorUpdate" },
  fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
  config = function()
    require("config.vimspector").setup()
  end,
}


  -- use 'mg979/vim-visual-multi'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
