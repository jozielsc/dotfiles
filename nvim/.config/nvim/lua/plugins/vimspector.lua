return {
  {
    "puremourning/vimspector",
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
    init = function()
      vim.g.vimspector_enable_mappings = "HUMAN"
    end,
  },
}
