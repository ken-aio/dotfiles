return {
  -- メインのGo開発環境
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = {'go', 'gomod', 'gowork', 'gotmpl'},
    config = function()
      require('go').setup({
        -- gopls の設定
        lsp_cfg = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        -- コード診断の設定
        diagnostic = {
          enable = true,
          virtual_text = true,
        },
        -- ハイライト設定
        highlight = {
          enable = true,
          operators = true,
          functions = true,
          variables = true,
          types = true,
          fields = true,
        },
        -- テスト設定
        test_runner = 'go',
        run_in_floaterm = true,
        -- タグの自動生成設定
        tag_transform = false,
        -- デバッグ設定
        dap_debug = true,
        -- lsp設定
        lsp_document_formatting = true,
        -- imports設定
        lsp_inlay_hints = {
          enable = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      })

      -- シンタックスハイライトの設定
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- 基本的なハイライト
          vim.opt_local.syntax = "on"
          
          -- Goのハイライト設定
          local highlight_groups = {
            goField = { fg = "#66D9EF" },           -- フィールド
            goFunction = { fg = "#A6E22E" },        -- 関数
            goFunctionCall = { fg = "#A6E22E" },    -- 関数呼び出し
            goVarDefs = { fg = "#FD971F" },         -- 変数定義
            goVarAssign = { fg = "#FD971F" },       -- 変数代入
            goVar = { fg = "#FD971F" },             -- 変数
            goConst = { fg = "#AE81FF" },           -- 定数
            goType = { fg = "#66D9EF" },            -- 型
            goTypeName = { fg = "#66D9EF" },        -- 型名
            goBuiltins = { fg = "#AE81FF" },        -- ビルトイン
            goPackage = { fg = "#F92672" },         -- パッケージ
            goImport = { fg = "#F92672" },          -- インポート
            goComment = { fg = "#75715E" },         -- コメント
            goString = { fg = "#E6DB74" },          -- 文字列
          }

          -- ハイライトグループの適用
          for group, colors in pairs(highlight_groups) do
            vim.api.nvim_set_hl(0, group, colors)
          end
          
          -- エラーハイライト
          vim.api.nvim_set_hl(0, 'goErr', { fg = '#FF0000', bold = true })
          vim.fn.matchadd('goErr', '\\<err\\>')
        end
      })

      -- 自動保存時のGoImport実行
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          -- GoImportコマンドを実行
          vim.cmd("GoImport")
        end,
        desc = "Auto run GoImport on save"
      })

      -- キーマッピング
      local opts = { noremap = true, silent = true }
      -- 基本的な機能
      vim.keymap.set('n', '<leader>gt', '<cmd>GoTest<CR>', opts)
      vim.keymap.set('n', '<leader>gr', '<cmd>GoRun<CR>', opts)
      vim.keymap.set('n', '<leader>gb', '<cmd>GoBuild<CR>', opts)
      vim.keymap.set('n', '<leader>gf', '<cmd>GoFillStruct<CR>', opts)
      vim.keymap.set('n', '<leader>gi', '<cmd>GoImport<CR>', opts)
      
      -- デバッグ関連
      vim.keymap.set('n', '<leader>gdb', '<cmd>GoDebug<CR>', opts)
      vim.keymap.set('n', '<leader>gdt', '<cmd>GoDebugTest<CR>', opts)
      vim.keymap.set('n', '<leader>gdr', '<cmd>GoDebugRestart<CR>', opts)
      
      -- コード解析・リファクタリング
      vim.keymap.set('n', '<leader>gc', '<cmd>GoCoverage<CR>', opts)
      vim.keymap.set('n', '<leader>gl', '<cmd>GoLint<CR>', opts)
      vim.keymap.set('n', '<leader>ga', '<cmd>GoAlt<CR>', opts)
      vim.keymap.set('n', '<leader>gm', '<cmd>GoModTidy<CR>', opts)
    end,
  },

  -- TreeSitter設定
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'go', 'gomod', 'gowork' },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- デバッグ用のプラグイン
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('dap-go').setup({
        -- delve の設定
        delve = {
          initialize_timeout_sec = 20,
          port = "${port}",
        },
      })
    end,
  },

  -- コード補完の強化
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- スニペット
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip').add_snippets('go', {
        -- Goのスニペット定義
        require('luasnip').snippet(
          { trig = "eif", name = "Error If" },
          {
            require('luasnip').text_node({"if err != nil {", "\treturn err", "}"})
          }
        ),
        -- 他のスニペットもここに追加可能
      })
    end,
  },
}