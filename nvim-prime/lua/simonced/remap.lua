
-- spacebar as my leader
vim.g.mapleader = " "

-- remove some bindings
vim.keymap.set("n", "Q", "<nop>")

-- esc replacement in insert mode
vim.keymap.set("i","fj", "<esc>")
vim.keymap.set("i","jf", "<esc>")

vim.keymap.set("n","<leader><CR>", ":w<CR>")
-- vim.keymap.set("n","<leader>so", ":so<CR>")

-- toggle highlight search
-- vim.keymap.set("n", "<leader> ", ":set hlsearch!<CR>")
vim.keymap.set("n", "<leader> ", ":noh<CR>")

-- selection (indent and move)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- window/split switching
vim.keymap.set("n", "<C-h>", "<C-w>h", {remap=false})
vim.keymap.set("n", "<C-j>", "<C-w>j", {remap=false})
vim.keymap.set("n", "<C-k>", "<C-w>k", {remap=false})
vim.keymap.set("n", "<C-l>", "<C-w>l", {remap=false})

-- vim.keymap.set("n", "<leader>fn", ":NeoTreeFocusToggle reveal<CR>", {remap=false})
vim.keymap.set("n", "<leader>fn", ":NeoTreeRevealToggle<CR>", {remap=false})

-- closing stuff:
-- buffer
vim.keymap.set("n","<leader>bb", ":bp|bd #<CR>")
-- window / frame
vim.keymap.set("n","<leader>ww", ":close<CR>")
-- quickfix window
vim.keymap.set("n","<leader>qq", ":cclose<CR>")
-- バッファを閉じる
vim.keymap.set('n', '<c-q>', ':quit<CR>', {remap=false})

-- resize buffer
-- + buffer size vertically
vim.keymap.set('n', '<s-h>', ':vert resize +15<cr>', {remap=false})
-- - buffer vertically
vim.keymap.set('n', '<s-l>', ':vert resize -15<cr>', {remap=false})

-- save
vim.keymap.set('n', '<leader>s', ':w<cr>', {remap=false})

-- semicolon as a colon
vim.keymap.set('n', ';', ':', {remap=false})
vim.keymap.set('n', ':', ';', {remap=false})
vim.keymap.set('v', ';', ':', {remap=false})
vim.keymap.set('v', ':', ';', {remap=false})

-- vim-easy-align
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

vim.keymap.set('n', '[q', ':cprev<cr>', {remap=false})
vim.keymap.set('n', ']q', ':cnext<cr>', {remap=false})

-- vim.keymap.set('n', '[a', ':AerialPrev<cr>', {remap=false})
-- vim.keymap.set('n', ']a', ':AerialNext<cr>', {remap=false})
vim.keymap.set('n', ']q', ':cnext<cr>', {remap=false})


local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd
Hydra({
   name = 'Lsp',
   config = {
      invoke_on_body = true,
      hint = {
			   type = 'window',
         position = 'middle',
         border = 'rounded',
      },
   },
   mode = 'n',
   body = '<Leader>p',
   heads = {
      -- { 'r', cmd 'LspRestart', { desc = 'LspRestart'} },
      {
				'r',
				function()
					print("restarting lsp...")
					vim.api.nvim_command('LspStop')
					vim.api.nvim_command('LspStart')
					print("restarted")
				end,
				{ exit = true, desc = 'LspRestart'}
			},
      { 'i', cmd 'LspInfo', { desc = 'LspInfo'} },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})

vim.lsp.get_active_clients()

function SwapImplTest()
	local currentFileName = vim.api.nvim_buf_get_name(0)
	local otherFile

	-- generate other file name
	if string.match(currentFileName, "_test") then
		-- open the non test file
		otherFile = string.gsub(currentFileName, "_test", "")
	else
		-- open the test file
		otherFile = string.gsub(currentFileName, ".go", "_test.go")
	end

	-- open file if it exists
	local f = io.open(otherFile, "r")
	if f ~= nil then
		io.close(f)
		vim.cmd("e " .. otherFile)
	else
		print("Other file doesn't exist")
	end
end
vim.keymap.set("n", "<leader>tt", ":lua SwapImplTest()<CR>", {remap = false})

function StartNewNvim()
	print("starting new Neovim instance...")
	-- print(vim.fn.getpid())

	local launchCmd = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
	launchCmd = launchCmd .. " -executionpolicy remotesigned"
	launchCmd = launchCmd .. " -File C:\\app\\nvim-win64\\v.ps1"

	vim.fn.system(launchCmd)
end
vim.keymap.set("n", "<leader>nv", ":lua StartNewNvim()<CR>", {remap = false})

vim.keymap.set("n", "<leader>w", ":w<CR>", {remap = false})


-- require('lint').linters_by_ft = {
  -- go = {'C:\\Users\\kimura.AZET\\go\\bin\\revive.exe',}
  -- go = {'revive.exe',}
  -- go = {'revive',}
-- }

-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufWritePost" }, {
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

vim.keymap.set("n", "<leader>ap", ":ALEPopulateQuickfix<CR>", {remap = false})

vim.keymap.set("n", "<leader>T", ":TestNearest<CR>", {remap = false})
vim.cmd[[
  let g:test#echo_command = 1
]]
