return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      -- Load luvit types when the 'vim.uv' word is found
      Library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } }, },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local tel_builtin = require('telescope.builtin')
          map('grn', vim.lsp.buf.rename, '[R]e[N]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('grr', tel_builtin.lsp_references, '[G]oto [R]eferences')
          map('gri', tel_builtin.lsp_implementations, '[G]oto [I]mplementations')
          map('grd', tel_builtin.lsp_definitions, '[G]oto [D]efinitions')
          map('gO', tel_builtin.lsp_document_symbols, '[O]pen Document Symbols')
          map('gW', tel_builtin.lsp_dynamic_workspace_symbols, 'Open [W]orkspace Symbols')
          map('grt', tel_builtin.lsp_type_definitions, '[G]oto [T]ype Definition')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has('nvim-0.11') == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        bashls = {},
        pylsp = {},
        jdtls = {},
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace', }, }, }, },
        stylua = {},
      }

      require('mason-tool-installer').setup({ vim.tbl_keys(servers or {}) })
      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  }
}
