return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )

    -- =====================
    -- Pyright (apenas type checking)
    -- =====================
    vim.lsp.config("pyright", {
      cmd = {"basedpyright-langserver", "--stdio"},
      settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "workspace",
                inlayHints = {
                    callArgumentNames = true,
                },
                autoImportCompletions = true,
                autoSearchPaths = true,
            },
            disablePrganizeImports = true,
        }
      },
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    vim.lsp.enable("pyright")

    -- =====================
    -- Ruff LSP
    -- =====================
    vim.lsp.config("ruff", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false

        vim.api.nvim_create_user_command("RuffFix", function()
          vim.lsp.buf.code_action({
            context = { only = { "source.fixAll.ruff" } },
            apply = true,
          })
        end, { desc = "Executar Ruff fix" })

        vim.api.nvim_create_user_command("RuffSort", function()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports.ruff" } },
            apply = true,
          })
        end, { desc = "Ordenar imports com Ruff" })
      end,
    })

    vim.lsp.enable("ruff")
  end,
}

