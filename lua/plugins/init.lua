local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  -- my plugins here

  -- core stuff
  use("nvim-lua/plenary.nvim")

  -- extended editor functionality
  use({ "mhinz/vim-grepper", cmd = "GrepperRg" })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = false,
        git = {
          enable = true,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
            },
          },
        },
        view = {
          side = "right",
        },
      })
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = { "python", "javascript", "lua" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          -- `false` will disable the whole extension

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        autotag = { -- Auto tag html
          enable = true,
          filetypes = { "html", "xml", "javascriptreact", "typescriptreact" },
        },
        rainbow = {
          enable = false,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- colors = {}, -- table of hex stringsnes = nil, -- Do not enable for files with more than n lines, int
          -- termcolors = {} -- table of colour name strings
        },
      })
    end,
  })

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("telescope").setup({})
    end,
  })

  -- theme stuff
  use("kyazdani42/nvim-web-devicons")
  use("folke/tokyonight.nvim") -- color scheme
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup()
    end,
  })

  -- git stuff
  use("tpope/vim-fugitive")

  -- lsp stuff
  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.null-ls")
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
