return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  
  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
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