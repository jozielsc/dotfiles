return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        cssls = {},

        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },

        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        html = {},

        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,

                diagnosticSeverityOverrides = {
                  -- DEIXA TUDO DE UNUSED PARA O RUFF
                  reportUnusedImport = "none",
                  reportUnusedVariable = "none",
                  reportUnusedFunction = "none",
                  reportUnusedExpression = "none",
                },
              },
            },
          },
        },

        ruff = {
          init_options = {
            settings = {
              fixAll = true,
              organizeImports = true,
            },
          },
        },

        lua_ls = {
          -- Força o uso do binário nativo do Void (instalado via xbps)
          cmd = { "lua-language-server" },
          settings = {
            Lua = {
              diagnostics = {
                -- Reconhece a variável global `vim`
                globals = { "vim" },
              },
              workspace = {
                -- Suprime o prompt chato de ambiente de terceiros
                checkThirdParty = false,
                -- Faz o servidor ler a documentação e os tipos da API do Neovim
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
          format = {
            enable = false,
          },
        },
      },
    },
  },
}
