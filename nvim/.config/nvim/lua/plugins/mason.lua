return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        -- LSPs
        "basedpyright",
        --        "lua-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",

        -- Tools (format / lint)
        "ruff",
        "shellcheck",
        "shfmt",
        "luacheck",
      })
    end,
  },
}
