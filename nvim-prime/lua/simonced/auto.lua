
-- trying to reset IME to romaji when we leave insertMode
-- spoiler alert: not working...
AugroupIME = vim.api.nvim_create_augroup("IMEreset", {clear = true})
vim.api.nvim_create_autocmd("InsertLeave", {
	command = "set iminsert=0",
	group = AugroupIME,
})

-- auto open location list after a :vim or :grep command
vim.api.nvim_exec([[
	augroup autolocationlist
		autocmd!
		autocmd QuickFixCmdPost [^l]* cwindow | redraw
	augroup END
]], false)


-- auto reload files when changed on disk
vim.api.nvim_exec([[
	set autoread
	augroup autoreload
		autocmd!
		autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
	augroup END
]], false)

-- auto format go files when saving
vim.api.nvim_exec([[
	augroup autogofmt
		autocmd!
		autocmd BufWritePost *.go silent! !go fmt %
	augroup END
]], false)

-- function jump for go using Aerial
vim.api.nvim_exec([=[
augroup gojumpremap
  autocmd!
  autocmd Filetype go nnoremap [[ :AerialPrev<CR>
  autocmd Filetype go nnoremap ]] :AerialNext<CR>
augroup END
]=], false)

-- カレントフォルダをタイトルバーに表示
-- vim.api.nvim_exec([[
-- augroup dirchange
--    autocmd!
--    autocmd BufEnter * let &titlestring=v:event['cwd']
-- augroup END
-- ]], false)

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*" },
	callback = function()
		vim.opt.titlestring = "📁 " .. vim.fn.getcwd() .. " ⟩ 📄 " .. vim.fn.expand("%:~:.")
	end,
	group = vim.api.nvim_create_augroup('autotitle', {}),
})


vim.api.nvim_exec([[
	autocmd FileType php set commentstring=//\ %s
]], false)

