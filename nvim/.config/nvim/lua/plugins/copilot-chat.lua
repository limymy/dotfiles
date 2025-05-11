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
          prompt         = "请用简体中文讲解选中的代码",
          system_prompt  = require('CopilotChat.config.prompts').COPILOT_EXPLAIN.system_prompt, -- 复用官方“解释”基调
          description    = "使用中文解释",
          mapping        = "<leader>ae",
        },
      }
    }
  }
}
