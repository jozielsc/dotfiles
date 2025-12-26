return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    -- PARSERS GARANTIDOS
    ensure_installed = {
      -- base
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- python
      "python",

      -- web / frontend
      "javascript",
      "typescript",
      "tsx",
      "json",
      "html",
      "css",

      -- config / infra
      "yaml",
      "toml",
      "dockerfile",
      "bash",
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
      disable = { "python" }, -- python indent do TS ainda é instável
    },

    -- QUERY LINTER
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
  },
}
