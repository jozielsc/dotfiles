return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- 1. Configuração do adaptador usando o lldb-dap nativo do Void
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap", -- Binário instalado via `xbps-install -S lldb`
        name = "lldb",
      }

      -- 2. Configurações de execução para C++
      dap.configurations.cpp = {
        {
          name = "Launch (lldb)",
          type = "lldb",
          request = "launch",
          program = function()
            -- Pede o caminho do executável na hora de iniciar o debug
            return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          -- Garante que as variáveis de ambiente do seu terminal sejam repassadas
          env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
              table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
          end,
        },
      }

      -- 3. Reutiliza a mesma configuração para C e Rust
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- 4. Atalhos de teclado básicos (opcional, mas muito recomendado)
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end, { desc = "DAP: Iniciar/Continuar" })
      vim.keymap.set("n", "<F8>", function()
        dap.step_over()
      end, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F9>", function()
        dap.step_into()
      end, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F10>", function()
        dap.step_out()
      end, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>b", function()
        dap.toggle_breakpoint()
      end, { desc = "DAP: Alternar Breakpoint" })
    end,
  },
}
