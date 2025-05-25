return {
  -- vim-go
  {
    'fatih/vim-go',
    ft = 'go',
    config = function()
      -- vim-goの基本設定
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_interfaces = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_fields = 1

      -- GoMetaLinter設定
      vim.g.go_metalinter_autosave = 1
      vim.g.go_metalinter_command = "golangci-lint"
      vim.g.go_fmt_command = "goimports"

      -- キーマッピング
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- 基本的なキーマッピング
          local opts = { buffer = true }
          vim.keymap.set('n', 'gb', '<cmd>GoBuild<CR>', opts)
          vim.keymap.set('n', 'gbb', '<cmd>GoTestFunc<CR>', opts)
          vim.keymap.set('n', 'gl', '<cmd>GoLint<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>GoReferrers<CR>', opts)
          vim.keymap.set('n', 'gf', '<cmd>GoIfErr<CR>', opts)
          vim.keymap.set('n', 'gh', '<cmd>GoSameIds<CR>', opts)
          vim.keymap.set('n', 'gi', '<cmd>GoInfo<CR>', opts)
          vim.keymap.set('n', 'gd', '<cmd>GoDoc<CR>', opts)
          vim.keymap.set('n', 'gc', '<cmd>GoCoverageToggle<CR>', opts)
          vim.keymap.set('n', 'ga', '<cmd>GoAddTags<CR>', opts)
          vim.keymap.set('n', 'gn', '<cmd>GoRename<CR>', opts)

          -- Leader キーマッピング
          vim.keymap.set('n', '<Leader>r', '<Plug>(go-run)', opts)
          vim.keymap.set('n', '<Leader>b', '<Plug>(go-build)', opts)
          vim.keymap.set('n', '<Leader>t', '<Plug>(go-test)', opts)
          vim.keymap.set('n', '<Leader>c', '<Plug>(go-coverage)', opts)
          vim.keymap.set('n', '<Leader>ds', '<Plug>(go-def-split)', opts)
          vim.keymap.set('n', '<Leader>dv', '<Plug>(go-def-vertical)', opts)
          vim.keymap.set('n', '<Leader>dt', '<Plug>(go-def-tab)', opts)
          vim.keymap.set('n', '<Leader>gd', '<Plug>(go-doc)', opts)
          vim.keymap.set('n', '<Leader>gv', '<Plug>(go-doc-vertical)', opts)
          vim.keymap.set('n', '<Leader>gb', '<Plug>(go-doc-browser)', opts)
          vim.keymap.set('n', '<Leader>s', '<Plug>(go-implements)', opts)
          vim.keymap.set('n', '<Leader>i', '<Plug>(go-info)', opts)
          vim.keymap.set('n', '<Leader>e', '<Plug>(go-rename)', opts)

          -- エラーハイライト
          vim.cmd [[highlight goErr cterm=bold ctermfg=214]]
          vim.cmd [[match goErr /\<err\>/]]
        end
      })
    end
  },
  
  -- gitgutter
  {
    'airblade/vim-gitgutter',
    config = function()
      -- キーマッピング
      vim.keymap.set('n', ',gg', '<cmd>GitGutterToggle<CR>', { silent = true })
      vim.keymap.set('n', ',gh', '<cmd>GitGutterLineHighlightsToggle<CR>', { silent = true })
    end
  }
}