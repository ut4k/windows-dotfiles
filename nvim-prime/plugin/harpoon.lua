
-- add mark/file to harpoon
vim.keymap.set("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
	print("Mark added.")
end, {remap=false})

-- show the harpoon list
vim.keymap.set("n", "<leader>hh", function()
	require("harpoon.ui").toggle_quick_menu()
end, {remap=false})

