-- Personal overrides layered on top of nicknisi's config.
-- Kept separate from lua/nisi/* so the upstream fork stays easy to sync.
-- Each submodule only *adds to* or *overrides a narrow slice of* nisi's
-- config (via vim.lsp.enable/config and conform's mergeable setup()),
-- rather than editing nisi's files directly.

local M = {}

function M.setup()
  require("zuhaibz.lsp").setup()
  require("zuhaibz.format").setup()
  require("zuhaibz.keymaps").setup()
end

return M
