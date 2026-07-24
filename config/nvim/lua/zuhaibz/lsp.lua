-- Python LSP: basedpyright (types/nav) + ruff (lint/fixes), instead of nisi's
-- pylsp. pylsp is disabled here (vim.lsp.enable(name, false)) rather than
-- removed from lua/nisi/plugins/lsp/config.lua, so that file stays untouched.

local M = {}

function M.setup()
  -- pylsp conflicts with basedpyright/ruff (duplicate diagnostics & hover); turn it off.
  vim.lsp.enable("pylsp", false)

  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          -- match VSCode/Pylance's default project-wide analysis instead of
          -- basedpyright's "openFilesOnly" default
          diagnosticMode = "workspace",
          -- deliberately NOT setting useLibraryCodeForTypes: basedpyright docs
          -- discourage it since it overrides per-project pyproject.toml config
        },
      },
    },
  })

  vim.lsp.config("ruff", {
    on_attach = function(client)
      -- basedpyright owns hover/type info; ruff only lints + fixes + organizes imports
      client.server_capabilities.hoverProvider = false
    end,
  })

  vim.lsp.enable("basedpyright")
  vim.lsp.enable("ruff")

  -- C#/.NET: omnisharp. Not in nisi's servers table at all.
  -- LoadProjectsOnDemand + AnalyzeOpenDocumentsOnly keep large solutions fast
  -- by only loading/analyzing projects for files you actually open, instead
  -- of eagerly loading the whole .sln up front.
  vim.lsp.config("omnisharp", {
    handlers = {
      -- omnisharp-extended-lsp resolves definitions/references in decompiled
      -- external assemblies, which plain omnisharp can't do
      ["textDocument/definition"] = function(...)
        return require("omnisharp_extended").handler(...)
      end,
      ["textDocument/typeDefinition"] = function(...)
        return require("omnisharp_extended").handler(...)
      end,
      ["textDocument/implementation"] = function(...)
        return require("omnisharp_extended").handler(...)
      end,
      ["textDocument/references"] = function(...)
        return require("omnisharp_extended").references_handler(...)
      end,
    },
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true,
        OrganizeImports = true,
      },
      MsBuild = {
        LoadProjectsOnDemand = true,
      },
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = true,
        EnableImportCompletion = true,
        AnalyzeOpenDocumentsOnly = true,
      },
    },
  })
  vim.lsp.enable("omnisharp")

  -- Make sure mason has these installed (nisi's mason_lspconfig ensure_installed
  -- list doesn't know about these servers since they're not in its `servers` table)
  local ok, registry = pcall(require, "mason-registry")
  if ok then
    registry.refresh(function()
      for _, name in ipairs({ "basedpyright", "ruff", "omnisharp" }) do
        local pkg_ok, pkg = pcall(registry.get_package, name)
        if pkg_ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end
end

return M
