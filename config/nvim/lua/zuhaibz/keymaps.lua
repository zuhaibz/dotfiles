-- Extra symbol-search keymaps not provided by nisi's telescope config.
-- Note: nisi maps <leader>gc/<leader>gs (git commits/status) when inside a git
-- repo, so <leader>g here shares a prefix with those — Neovim will wait
-- timeoutlen ms to disambiguate, same as any other multi-key leader prefix.

local M = {}

function M.setup()
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    return
  end

  vim.keymap.set("n", "<leader>g", builtin.lsp_document_symbols, { desc = "Search symbols in buffer" })
  vim.keymap.set(
    "n",
    "<leader>G",
    builtin.lsp_dynamic_workspace_symbols,
    { desc = "Search symbols in workspace" }
  )
end

return M
