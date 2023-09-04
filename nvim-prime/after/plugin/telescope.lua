local builtin = require('telescope.builtin')
require'telescope'.load_extension('project')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local lga_actions = require("telescope-live-grep-args.actions")

local pickers = require("telescope.pickers") 
local finders = require("telescope.finders") 
local utils = require("telescope.utils")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require('telescope.actions')
local actions_set = require('telescope.actions.set')
local from_entry = require('telescope.from_entry')
local actions_state = require('telescope.actions.state')

require('telescope').setup{
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { height = 0.95 },
	},
  extensions = {
    project = {
      base_dirs = {
        {'C:/workspace/'},
        {'C:/workspace/surala-ibl/'},
        {'C:/workspace/surala/'},
      },
      -- theme = "dropdown",
      order_by = "asc",
      search_by = "title",
    }
  },
	live_grep_args = {
		auto_quoting = false, -- enable/disable auto-quoting
		-- define mappings, e.g.
		mappings = { -- extend mappings
		i = {
			["<C-k>"] = lga_actions.quote_prompt(),
			["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
		},
	},
	-- ... also accepts theme settings, for example:
	-- theme = "dropdown", -- use dropdown theme
	-- theme = { }, -- use own theme spec
	-- layout_config = { mirror=true }, -- mirror preview pane
}
}


-- helper to search in config folder
function Vimfiles()
	-- folder of different system
	-- local folder = "~/.config/nvim-prime"
	-- if package.config:sub(1,1) == '\\' then
		folder =  "~/Appdata/Local/nvim-prime"
	-- end
	local opts = {
		cwd = folder,
	--	file_ignore_patterns = {'.git'},
	--	previewer = false,
		-- try to not show the whole path because I don't need it: none of below seems to work...
	--	shorten_path = true,
		-- path_display = {"smart"},
	}
	builtin.find_files(opts)
end

-- helper to search in config folder
function TsProjects()
	folder =  "C:/workspace"
	local opts = {
		prompt_title = "Open Project",
		cwd = folder,
		previewer = false,
		prompt_prefix="🔍 > ",
		find_command = {
			"fd",
			"--type", "d",
			"--max-depth", "1",
			"--strip-cwd-prefix"
		},
	}
	builtin.find_files(opts)
end

function findTeleScopeEntries()
	utils.get_os_command_output(cmd)
end

local cdPicker = function(name, cmd)
    pickers.new({}, {
        prompt_title = name,
        finder = finders.new_table{
					results = utils.get_os_command_output(cmd)
				},
        previewer = previewers.vim_buffer_cat.new({}),
        sorter = sorters.get_fuzzy_file(),
        attach_mappings = function(prompt_bufnr)
            actions_set.select:replace(function(_, type)
                local entry = actions_state.get_selected_entry()
                actions.close(prompt_bufnr)
                local dir = from_entry.path(entry)
                vim.cmd('cd '..dir)
								vim.cmd('LspStop')
								vim.cmd('echo "lsp stopped."')
            end)
            return true
        end,
    }):find()
end

function Cd(path)
    path = path or '.'
    cdPicker(path, {"fd", ".", path, "--type=d", "--max-depth=1", "--", ".", path .. "\\surala-ibl"})
end

function Cdz()
    cdPicker('z directories', {vim.o.shell, '-c', "cat ~/.z | cut -d '|' -f1"})
end


-- [e]dit [e]nvironment
vim.keymap.set("n","<leader>ee", ":lua Vimfiles()<CR>", {noremap=true, silent=true})

-- search [f]iles [o]ld
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {noremap=true})

-- [b]uffer [s]ymbols: list file symbols with treesitter

-- [w]orkspace [symbols] using lsp
vim.keymap.set('n', '<leader>ws', function()
	local q=vim.fn.input("Symbol partial name > ")
	builtin.lsp_workspace_symbols({query=q})
end, {noremap=true})

-- [f]ind [f]ile
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {noremap=true})
vim.keymap.set('n', '<c-p>', builtin.find_files, {noremap=true})

-- [w]orkspace [d]iagnostic
vim.keymap.set('n', '<leader>wd', builtin.diagnostics, {noremap=true})

-- search [f]iles in [g]it projects
vim.keymap.set('n', '<leader>fg', builtin.git_files, {noremap=true})

-- [g]rep [s]earch
-- vim.keymap.set('n', '<leader>gs', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end,
-- {noremap=true})

vim.keymap.set('n', '<leader>gs', require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
-- vim.keymap.set('n', '<leader>gs', live_grep_args_shortcuts.grep_word_under_cursor, { noremap = true })

-- open buffers list
vim.keymap.set('n', '<C-b>', builtin.buffers, {noremap=true})

-- select color scheme
vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {noremap=true})

-- vim.keymap.set('n', '<C-0>', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})
-- vim.keymap.set('n', '<C-0>', ":lua TsProjects()<CR>", {noremap = true, silent = true})
vim.keymap.set('n', '<C-0>', ":lua Cd('C:\\\\workspace')<CR>", {noremap = true, silent = true})

vim.keymap.set('n', '<leader>cw', function()
	builtin.grep_string({ search = vim.fn.expand('<cword>') })
end,
{noremap = true})

