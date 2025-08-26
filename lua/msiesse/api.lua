-- lua/appearance/transparent.lua (for example)

local function set_transparent()
  local groups = {
    "Normal", "NormalFloat", "FloatBorder", "Pmenu",
    -- optional extras people usually want transparent too:
    "NormalNC", "SignColumn", "LineNr", "FoldColumn",
    "EndOfBuffer", "StatusLine", "StatusLineNC", "WinSeparator",
    "TelescopeNormal", "TelescopeBorder", "NvimTreeNormal",
  }
  for _, group in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, group, { bg = "none" })
  end
  -- Optional: make popup/float blends subtle
  vim.opt.pumblend = 10
  vim.opt.winblend = 10
end

-- Apply once on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = set_transparent,
})

-- Re-apply after any colorscheme change (including at startup)
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = set_transparent,
})
