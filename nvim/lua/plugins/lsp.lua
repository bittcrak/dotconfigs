return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "clangd", "html", "cssls", "ts_ls", "lua_ls" },
        automatic_installation = true,
      })

      -- Get default capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- Setup LSP servers using new vim.lsp.config API
      local servers = {
        pyright = {},
        clangd = {},
        html = {},
        cssls = {},
        ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
}

