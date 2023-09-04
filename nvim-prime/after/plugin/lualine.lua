local lualine = require('lualine')

local function totalLines()
	return vim.api.nvim_buf_line_count(0)
end

local function currentLineNum()
	return vim.api.nvim__buf_stats(0).current_lnum
end

local function lineLocation()
	return currentLineNum() .. "/" .. totalLines()
end

local function showMacroRecording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "🔴 Recording @" .. recording_register
    end
end

local breadcrump_sep = " ⟩ "
lualine.setup {
	options = {
		-- icons_enabled = true,
		icons_enabled = true,
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		always_divide_middle = true,
		globalstatus = true,

		-- icons_enabled = false,
		-- section_separators = {left = ">", right = "<"},
		-- component_separators = {left = "\\", right = "/"},
	},
	sections = {
		-- lualine_a = {'mode'},
		-- lualine_a = {'branch', 'diff', 'diagnostics'},
		lualine_a = {'branch'},
		lualine_b = {
			{
				"filename",
				path = 1,
				separator = vim.trim(breadcrump_sep),
				fmt = function(str)
					local path_separator = package.config:sub(1, 1)
					return str:gsub(path_separator, breadcrump_sep)
				end
			},
			{ "aerial", sep = breadcrump_sep },
			{
				"macro-recording",
				fmt = showMacroRecording,
			},
		},
		lualine_c = {
			{
				'filename',
				path = 1,
				fmt = function(str)
					return "📄 " .. str
				end
			},
			'diagnostics',
		},
		-- lualine_x = {'encoding', 'fileformat', 'filetype'},

		-- Aerial.nvim
    -- lualine_x = { "aerial" },
    -- Or you can customize it
    -- lualine_y = {{ "aerial",
    -- lualine_y = {{ "aerial",
    --   -- The separator to be used to separate symbols in status line.
    --   sep = ' ) ',
    --
    --   -- The number of symbols to render top-down. In order to render only 'N' last
    --   -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
    --   -- be used in order to render only current symbol.
    --   depth = nil,
    --
    --   -- When 'dense' mode is on, icons are not rendered near their symbols. Only
    --   -- a single icon that represents the kind of current symbol is rendered at
    --   -- the beginning of status line.
    --   dense = false,
    --
    --   -- The separator to be used to separate symbols in dense mode.
    --   dense_sep = '.',
    --
    --   -- Color the symbol icons.
    --   colored = true,
    -- }},

		lualine_y = {},
		-- lualine_z = {'location'}
		lualine_z = {lineLocation}


	},
	inactive_sections = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
		lualine_c = {{'filename', path = 1}},
	-- 	lualine_x = {'location'},
	-- 	lualine_y = {},
	-- 	lualine_z = {}
	},
}

