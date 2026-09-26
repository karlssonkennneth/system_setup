-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
--
-- NOTE: Python DAP (nvim-dap-python, mason-nvim-dap's python handler) is
-- already configured by LazyVim's `lazyvim.plugins.extras.lang.python` extra.
-- Don't call mason-nvim-dap.setup()/dap-python.setup() again here - doing so
-- caused a circular require crash ("loop or previous error loading module
-- 'mason-nvim-dap.mappings.configurations'") whenever a DAP keymap was used.
-- Instead, this file only adds Go support and overrides the Python DAP setup
-- with your custom venv/launch config via their own plugin specs below.

return {
  {
    -- NOTE: Yes, you can install new plugins here!
    "mfussenegger/nvim-dap",
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Required dependency for nvim-dap-ui
      "nvim-neotest/nvim-nio",

      -- Installs the debug adapters for you
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Run/Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dP",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup({
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
  },

  -- mason-nvim-dap.nvim already gets `handlers.python = noop` from LazyVim's
  -- python extra (so it doesn't fight with nvim-dap-python below). Just add
  -- Go's delve here - `opts` gets merged with the extra's opts, and lazy.nvim
  -- calls setup() automatically exactly once.
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "delve" },
    },
  },

  -- Override LazyVim's default nvim-dap-python config (which points at the
  -- mason-installed "debugpy-adapter") to use your own venv's debugpy, and
  -- add your custom launch config on top of it.
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup("/Users/kennethkarlsson/python_virtualenv_313/bin/python")
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Testing a CLI",
        args = { "one", "--value", "Testing value" },
        program = "/Users/kennethkarlsson/test/python_unit_test/python_cli.py",
        -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      })
      require("dap-python").test_runner = "pytest"
    end,
  },
}
