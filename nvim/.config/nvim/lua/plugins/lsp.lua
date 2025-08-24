return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities()
    )

    lspconfig.pyright.setup({
        
        on_attach = function(client, bufnr)
            -- Desabilita formatacao e linting, apenas type checking
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
        
    })

    -- Ruff LSP (substitui ruff_lsp)

    lspconfig.ruff.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr) 
        if client.server_capabilities.documentFormattingProvider then
            client.server_capabilities.hoverProvider = false

         vim.api.nvim_create_user_command("RuffFix", function()
             vim.lsp.buf.code_action({
                context = {only = {"source.fixAll.ruff"}},
                apply = true,
            })
         end,{desc="Executar Ruff fix"})

         vim.api.nvim_create_user_command("RuffSort", function()
             vim.lsp.buf.code_action({
                context = {only = {"source.organizeImports.ruff"}},
                apply = true,
            })
         end,{desc="Organiza imports"})

         vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("RuffFormatOnSave", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
           end,
          })
        end
     end,
      init_options = {
        settings = {
           args = {}
       },
     },
   })
   end
}

