return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",      -- Tab で提案を受け入れ
            accept_word = false,
            accept_line = false,
            next = "<M-]>",        -- Alt+] で次の提案
            prev = "<M-[>",        -- Alt+[ で前の提案
            dismiss = "<C-]>",     -- Ctrl+] で提案を却下
          },
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.jsコマンドのパス
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot cmp source（nvim-cmpとの統合）
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  
  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      show_help = "yes",
      debug = false,
      disable_extra_info = 'no',
      language = "Japanese"
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cpc", ":CopilotChat ", desc = "CopilotChat - Chat" },
      { "<leader>cpd", ":CopilotChatDebug ", desc = "CopilotChat - Debug" },
      { "<leader>cpe", ":CopilotChatExplain ", desc = "CopilotChat - Explain" },
      { "<leader>cpt", ":CopilotChatTests ", desc = "CopilotChat - Tests" },
      { "<leader>cpf", ":CopilotChatFix ", desc = "CopilotChat - Fix" },
      { "<leader>cpi", ":CopilotChatImplement ", desc = "CopilotChat - Implement" },
      { "<leader>cpo", ":CopilotChatOptimize ", desc = "CopilotChat - Optimize" },
    },
  }
}