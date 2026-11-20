require ('basic')
require ('linea_flash')
require ('explorer')
require ('auto_comando')
require ('buscar')
require ('git_net')
require ('lspx')    
require ('task')    
require ('ia_browser')    
require ('minipick')
require ('xterm')
require ('treesiterx')



-- Instalación automática de lazy.nvim (si aún no está instalado)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lista de plugins migrados desde Packer
require("lazy").setup({
  "nvim-lua/plenary.nvim",

  {
    "echasnovski/mini.pick",
    branch = "main",
    config = function()
      require("mini.pick").setup({
        options = {
          use_cache = true,
        },
        mappings = {},
      })
    end,
  },
{
  "Jezda1337/nvim-html-css",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    enable_on = {
      "html",
      "htmldjango",
      "tsx",
      "jsx",
      "erb",
      "svelte",
      "vue",
      "blade",
      "php",
      "templ",
      "astro",
    },
    handlers = {
      definition = {
        bind = "gd"
      },
      hover = {
        bind = "K",
        wrap = true,
        border = "none",
        position = "cursor",
      },
    },
    documentation = {
      auto_show = true,
    },
    peek = {
      enabled = true,
      border = "rounded",
      position = "center",
      width = 0.5,
      height = 0.5,
      focus = true,
      style = "minimal",
    },
  },
},
{
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "html",
          "jsonls",
          "ts_ls",
          "lua_ls",
          "pyright",
          "clangd",
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Recomendado para temas de color para que cargue al inicio
    priority = 1000, -- Asegura que cargue antes que los demás plugins
    config = function()
      require("tokyonight").setup({
        style = "moon",
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          sidebars = "dark",
          floats = "dark",
        },
      })
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
  },
{
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "python", "javascript"
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
    
})
