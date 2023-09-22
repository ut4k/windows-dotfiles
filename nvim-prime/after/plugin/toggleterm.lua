require("toggleterm").setup({

	-- FOR MSYS
  -- shell = "C:/msys64/usr/bin/bash.exe --login",
  -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
  -- direction = 'tab',

	-- COMMON
  direction = 'float'
})

local Terminal  = require('toggleterm.terminal').Terminal
local mingw64 = Terminal:new({
	-- cmd = "lazygit",
	hidden = true,
	on_open = function(term)
		vim.env.CHERE_INVOKING=1
		vim.env.MSYSTEM="MINGW64"
	end,
})

function _mingw64_toggle()
  mingw64:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>lua _mingw64_toggle()<CR>", {noremap = true, silent = true})
