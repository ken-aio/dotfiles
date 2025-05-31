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
      
      -- Copilot用のハイライト設定
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
      
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        formatting = {
          format = function(entry, vim_item)
            if entry.source.name == "copilot" then
              vim_item.kind = " Copilot"
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end
            return vim_item
          end
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
            -- Copilotの提案がある場合は、Copilotの提案を優先
            local copilot_suggestion = require("copilot.suggestion")
            if copilot_suggestion.is_visible() then
              copilot_suggestion.accept()
            elseif cmp.visible() then
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
          { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'vsnip', group_index = 2 },
        }, {
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

  -- 自動括弧閉じプラグイン
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      -- 基本設定
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = {"string", "source"},
          javascript = {"string", "template_string"},
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,
        enable_check_bracket_line = true,
        enable_bracket_in_quote = true,
        enable_abbr = false,
        break_undo = true,
        check_comma = true,
        map_cr = true,
        map_bs = true,
        map_c_h = false,
        map_c_w = false,
      })

      -- Golang専用の設定
      autopairs.add_rules({
        -- Golang構造体初期化の自動ペア
        Rule("&", "", "go"):with_pair(function(opts)
          local line = opts.line
          local col = opts.col
          -- 構造体名の後の&{}パターンを検出
          if line:sub(col-10, col):match("%w+%s*{$") then
            return true
          end
          return false
        end):with_move(cond.none()),

        -- Goのスライス・配列の自動ペア強化
        Rule("[", "]", "go"),
        
        -- Goの関数リテラル用の{}ペア
        Rule("{", "}", "go"):with_pair(function(opts)
          local line = opts.line
          local col = opts.col
          -- func()の後の{}を検出
          if line:sub(col-6, col):match("func%(%s*%)%s*$") then
            return true
          end
          return true
        end),
      })

      -- nvim-cmpとの統合
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
}
