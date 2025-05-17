return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = {
      system_prompt = "你是一个乐于助人的编程助手。所有回答必须使用 **简体中文**。\n"
        .. require('CopilotChat.config.prompts').COPILOT_INSTRUCTIONS.system_prompt,
      model = "claude-3.7-sonnet",
      sticky = {
        '#files',
      },
      prompts = {
        explain = {
          prompt         = "请用简体中文详细讲解选中的代码",
          system_prompt  = require('CopilotChat.config.prompts').COPILOT_EXPLAIN.system_prompt, -- 复用官方“解释”基调
          description    = "使用中文解释",
          mapping        = "<leader>ae",
        },
        fix = {
          prompt         = "请分析这段代码并修复其中的问题，用简体中文回答",
          system_prompt  = require('CopilotChat.config.prompts').COPILOT_REVIEW.system_prompt, -- 复用官方“解释”基调
          description    = "使用中文修复",
          mapping        = "<leader>af",
        },
      },
      window = {
        width = 0.35,
      },
    }
  }
}
