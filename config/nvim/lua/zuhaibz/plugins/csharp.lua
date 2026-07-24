-- Better go-to-definition for OmniSharp: plain OmniSharp can't resolve
-- symbols in decompiled/external assemblies (common in large .NET solutions
-- with lots of NuGet references). This patches the definition/references
-- handlers only for C# buffers.

return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    ft = { "cs" },
  },
}
