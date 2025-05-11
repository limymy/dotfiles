return {
  "lervag/vimtex",
  ft = { "tex" },
  config = function()
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      -----   Windows   -----
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "sumatrapdf.exe"
      vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
      -- vim.g.vimtex_callback_progpath      = "nvr"   -- 反向搜索走 nvr
    else
      -----   Linux   -----
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_zathura_options = "--synctex-forward @line:@tex @pdf"
      -- vim.g.vimtex_callback_progpath      = "nvr"   -- 反向搜索走 nvr
    end
  end,
}
