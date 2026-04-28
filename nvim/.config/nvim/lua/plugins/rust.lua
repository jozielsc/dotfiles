return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      -- 1. Injetamos o adaptador DAP nativo do Void Linux
      dap = {
        adapter = {
          type = "executable",
          command = "/usr/bin/lldb-dap",
          name = "lldb",
        },
      },
      server = {
        on_attach = function(client, bufnr)
          local ns = vim.lsp.diagnostic.get_namespace(client.id)
          vim.diagnostic.config({
            underline = true,
            update_in_insert = false,
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
            },
            severity_sort = true,
          }, ns)

          -- Atalhos específicos para Rust (RustLsp)
          vim.keymap.set("n", "<Leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action (Rust)", buffer = bufnr })

          vim.keymap.set("n", "<Leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Debug (Rust)", buffer = bufnr })

          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp("hover")
          end, { desc = "Hover (Rust)", buffer = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
