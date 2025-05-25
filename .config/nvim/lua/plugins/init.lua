return {
  -- LSP関連
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    lazy = false,
    priority = 1000,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      -- コマンドラインの補完設定
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
        })
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 999,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    priority = 998,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local main = require("config.main")

      -- LSPサーバーの設定
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",    -- Lua
          "gopls",     -- Go
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = main.on_attach,
              capabilities = capabilities,
              handlers = main.handlers,
            })
          end,
        }
      })

      -- デフォルトの設定
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 各LSPサーバーの設定
    end
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- キーマッピングの設定
      vim.keymap.set('n', 'ff', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', 'fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', 'fb', '<cmd>Telescope buffers<cr>')
      vim.keymap.set('n', 'fh', '<cmd>Telescope help_tags<cr>')
    end
  },

  -- NERDTree
  {
    "preservim/nerdtree",
    config = function()
      -- NERDTreeの設定
      vim.keymap.set('n', '<C-e>', ':NERDTreeToggle<CR>', { silent = true })
      vim.g.NERDTreeWinSize = 25
    end
  },
}
