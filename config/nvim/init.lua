-- init.lua
-- Neovim-specific configuration

-- Use the nisi config

local nisi = require("nisi")

-- Register personal plugins before setup() so they're included in lazy's plugin list
nisi.add_plugin({ import = "zuhaibz.plugins" })

nisi.setup({
  python = true,
  transparent = true,
})

-- Personal overrides (kept out of lua/nisi/* to stay easy to sync with upstream)
require("zuhaibz").setup()
