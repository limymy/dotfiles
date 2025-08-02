return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      providers = {
        gemini = {
          model = "gemini-2.5-pro",
          api_key_name = "GEMINI_API_KEY",
        },
        copilot = {
          model = "claude-sonnet-4",
        },
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "qwen/qwen3-coder:free",
        },
      },
      behaviour = {
        auto_suggestions = true,
      },
      selector = {
        provider = "fzf_lua",
      },
    },
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = {
            enabled = false,
          },
          panel = {
            enabled = false,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai" },
      {
        "<leader>ae",
        function()
          require("avante.api").ask({ question = "请用中文详细解释选中的这段代码" })
        end,
        desc = "解释代码",
        mode = { "n", "v" },
      },
      {
        "<leader>ab",
        function()
          require("avante.api").ask({ question = "请分析这段代码并检查修复其中存在的问题" })
        end,
        desc = "修复bug",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        function()
          require("avante.api").ask({ question = "请分析这段代码并优化它的实现" })
        end,
        desc = "优化代码",
        mode = { "n", "v" },
      },
    },
  },
  -- This is a compatibility layer for Blink sources
  {
    "saghen/blink.cmp",
    lazy = true,
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        compat = {
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
    },
  },
}
