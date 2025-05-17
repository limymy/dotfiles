return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "DAP Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "DAP Step Over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "DAP Step Into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "DAP Step Out",
    },
    -- <leader>dS  ⇒  浮窗显示 Stacks，并自动把光标跳进去
    {
      "<leader>dS",
      function()
        require("dapui").float_element(
          "stacks",
          { enter = true, width = 60, height = 20, title = "调试堆栈", position = "center" }
        )
      end,
      desc = "DAP: Stacks (float)",
    },
  },
}
