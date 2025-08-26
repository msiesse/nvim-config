vim.keymap.set('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>') 
vim.keymap.set('n', '<leader>tn', ':lua require("neotest").run.run()<CR>') 
vim.keymap.set('n', '<leader>ts', ':lua require("neotest").run.stop()<CR>') 
vim.keymap.set('n', '<leader>to', ':lua require("neotest").output.open()<CR>') 
vim.keymap.set('n', '<leader>ti', ':lua require("neotest").summary.toggle()<CR>') 



require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require('neotest-pest'),
  }
})

