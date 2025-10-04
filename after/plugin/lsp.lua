-- Setup nvim-cmp
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "path" },
    }),
})

-- Setup LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP keybindings on attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client and client.name == "eslint" then
            vim.cmd.LspStop('eslint')
            return
        end

        local opts = { buffer = ev.buf, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        pcall(vim.keymap.del, 'n', 'gi', { buffer = ev.buf })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end,
})

-- Setup Mason first
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "rust_analyzer" },
    handlers = {
        function(server_name)
            -- This will be called for each installed server
            -- Mason will handle starting the servers using the new API
            vim.lsp.enable(server_name)
        end,
    },
})

-- Configure language servers using vim.lsp.config
vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

vim.lsp.config.pyright = {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off", -- disable type checker
                diagnosticMode   = "openFilesOnly",
            },
        },
    },
}

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
        },
    },
})
