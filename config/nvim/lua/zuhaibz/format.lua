-- Format python with ruff instead of black+isort.
-- conform.setup() shallow-merges formatters_by_ft per-filetype key, so this
-- only overrides the "python" entry from lua/nisi/plugins/lsp/init.lua
-- without touching that file or any other filetype's formatters.

local M = {}

function M.setup()
  local ok, conform = pcall(require, "conform")
  if not ok then
    return
  end

  conform.setup({
    formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
    },
  })
end

return M
