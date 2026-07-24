-- AI chat/agent panel (Zed-like clean chat buffer), not previously configured.
-- nisi's copilot.lua only does inline ghost-text suggestions - no chat/agent UI.
--
-- Both codecompanion.nvim and avante.nvim are configured here, both wired to
-- Copilot, so you can A/B them. Only one is enabled at a time - flip the
-- ACTIVE value below to switch. Both stay installed either way (cheap to
-- keep on disk, `enabled = false` just skips loading it on startup).

-- "codecompanion" | "avante"
local ACTIVE = "codecompanion"

return {
  {
    "olimorris/codecompanion.nvim",
    enabled = ACTIVE == "codecompanion",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>aic", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat (toggle)", mode = { "n", "v" } },
      { "<leader>aia", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions menu", mode = { "n", "v" } },
      { "<leader>aip", "<cmd>CodeCompanion<cr>", desc = "AI inline prompt", mode = { "v" } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            width = 0.4,
          },
        },
      },
    },
  },

  {
    "yetone/avante.nvim",
    enabled = ACTIVE == "avante",
    event = "VeryLazy",
    version = false, -- avante tracks main, no stable tags
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>aic", "<cmd>AvanteToggle<cr>", desc = "AI Chat (toggle)", mode = { "n", "v" } },
      { "<leader>aia", "<cmd>AvanteAsk<cr>", desc = "AI Ask", mode = { "n", "v" } },
      { "<leader>aip", "<cmd>AvanteEdit<cr>", desc = "AI inline prompt", mode = { "v" } },
    },
    opts = {
      provider = "copilot",
      windows = {
        width = 40,
      },
    },
  },
}

