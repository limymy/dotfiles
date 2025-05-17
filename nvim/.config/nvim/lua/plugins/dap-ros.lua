------------------------------------------------
----- Only for Linux
------------------------------------------------
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  return
end

-------------------------------------------------------------------
-- 表单处理函数，可以记忆并校验用户输入的值
-------------------------------------------------------------------
local function ask_once(var_name, prompt, validator)
  -- 尝试获取上次输入的值
  local last_value = vim.g[var_name] or ""
  -- 创建一个输入框
  local input_opts = {
    prompt = prompt,
    default = last_value,
  }
  local new_value = vim.fn.input(input_opts)
  -- 检查是否按了ESC取消输入
  if new_value == "" and vim.v.shell_error == 1 then
    vim.notify("Debug cancelled", vim.log.levels.INFO)
    return nil
  end
  -- 校验输入值
  if validator and not validator(new_value) then
    vim.notify("Invalid input: " .. new_value, vim.log.levels.ERROR)
    return nil
  end
  -- 记住这次输入的值
  vim.g[var_name] = new_value
  return new_value
end
-- 用 ros2 命令解析绝对路径；找不到就返回 nil
local function resolve_ros2_exe(pkg, exe)
  local prefix = vim.fn.systemlist({ "ros2", "pkg", "prefix", pkg })[1] or ""
  if prefix ~= "" then
    local candidate = string.format("%s/lib/%s/%s", prefix, pkg, exe)
    if vim.fn.filereadable(candidate) == 1 then
      return candidate
    end
  end
  return nil
end

return {
  "mfussenegger/nvim-dap",
  ft = { "cpp" },
  opts = function(_, opts)
    local dap = require("dap")
    -- ===== C++ / C =====
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    }
    dap.configurations.cpp = {
      {
        name = "🛠 Attach ros node via gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        justMyCode = false,
        program = function()
          -- 请求用户输入ROS2节点信息
          local input = ask_once("ros2_last_node", "ROS2 node (package/executable)", function(val)
            return val:match("([^/]+)/([^/]+)") ~= nil
          end)
          if input == nil then
            return nil
          end
          -- 解析包名和可执行文件名
          local pkg, exe = input:match("([^/]+)/([^/]+)")
          -- 调用ros2查询绝对路径
          local path = resolve_ros2_exe(pkg, exe)
          if not path then
            vim.notify(("无法解析可执行文件路径：%s/%s"):format(pkg, exe), vim.log.levels.ERROR)
            return nil
          end
          vim.notify(("Debug program：%s"):format(path), vim.log.levels.INFO)
          return path
        end,
        cwd = "${workspaceFolder}",
        setupCommands = {
          { text = "-enable-pretty-printing", ignoreFailures = true },
          { text = "set breakpoint pending on" },
        },
      },
    }
    dap.configurations.c = dap.configurations.cpp
    return opts
  end,
}
