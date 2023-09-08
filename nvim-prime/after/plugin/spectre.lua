require('spectre').setup({
	replace_engine={
		['sed']={
			-- cmd = "sed",
			cmd = "C:\\msys64\\usr\\bin\\sed.exe",
			args = nil
		},
	}
})

-- vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', {
--     desc = "Open Spectre"
-- })
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>S', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
-- vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--     desc = "Search on current file"
-- })
