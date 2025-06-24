return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "suketa/nvim-dap-ruby" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
        require("dap-ruby").setup()
        require('dapui').setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.keymap.set("n", "<Leader>dc", function()
        require("dap").continue()
      end)
      vim.keymap.set("n", "<Leader>so", function()
        require("dap").step_over()
      end)
      vim.keymap.set("n", "<Leader>si", function()
        require("dap").step_into()
      end)
      vim.keymap.set("n", "<Leader>so", function()
        require("dap").step_out()
      end)
      vim.keymap.set("n", "<Leader>tb", function()
        require("dap").toggle_breakpoint()
      end)
      vim.keymap.set("n", "<Leader>sb", function()
        require("dap").set_breakpoint()
      end)
      vim.keymap.set("n", "<Leader>bb", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end)
      vim.keymap.set("n", "<Leader>do", function()
        require("dap").repl.open()
      end)
      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end)
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end)
    end,
  },
}
