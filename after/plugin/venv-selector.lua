require('venv-selector').setup({})
vim.keymap.set('n', '<Leader>v', '<cmd>VenvSelect<CR>', { desc = 'VenvSelect' })
