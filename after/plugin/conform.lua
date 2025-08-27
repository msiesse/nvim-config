local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
    },
})

vim.keymap.set("n", "<leader>l", conform.format)
