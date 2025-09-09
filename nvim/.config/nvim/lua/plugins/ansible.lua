return {
    "mfussenegger/nvim-lint",
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.ansiblels.setup{
            settings = {
                ansible = {
                    ansibleLint = {
                        enabled = true,
                        path = "ansible-lint",
                    },
                    executionEnvironment = false,
                },
                yaml = {
                    validate = true,
                    hover = true,
                    completion = true
                }
            },
            filetypes = {"yaml.ansible", "yml"},
        }

        local lint = require("lint")
        lint.linters_by_ft = {
            yaml = {"ansible-lint", "yamllint"},
        }

        vim.api.nvim_create_autocmd({"BufWritePost"}, {
            pattern = {"*.yml", "*.yaml"},
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
