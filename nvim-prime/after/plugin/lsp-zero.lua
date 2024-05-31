-- lsp things
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

	-- TODO add custom lsp bindings only mappings here
end)

-- Configure LSP
local lspconfig = require('lspconfig')
local configs = require 'lspconfig/configs'
-- local util = require('lspconfig').util

-- LUA
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
-- lspconfig.lua_ls.setup({
-- 			cmd = {"C:\\Users\\kimura.AZET\\AppData\\Local\\nvim-prime-data\\mason\\packages\\lua-language-server\\bin\\lua-language-server.exe"},
-- })

lspconfig.hls.setup(lsp)


-- srn go settings
lspconfig.gopls.setup {
	cmd_env = {GOFLAGS="-tags=test_fixture,test_login"},
}

-- golangcilsp (lint)
-- if not configs.golangcilsp then
--  	configs.golangcilsp = {
-- 		default_config = {
-- 			-- cmd = {'golangci-lint-langserver'},
-- 			cmd = {'C:\\Users\\kimura.AZET\\go\\bin\\golangci-lint-langserver.exe'},
-- 			root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
-- 			init_options = {
-- 					command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", "--issues-exit-code=1" };
-- 			}
-- 		};
-- 	}
-- end
-- lspconfig.golangci_lint_ls.setup {
-- 	filetypes = {'go','gomod'}
-- }

-- Configure PHP WP LSP
lspconfig.intelephense.setup({
		-- root_dir = util.root_pattern(".git", "index.php"),
	root_dir = require("lspconfig").util.root_pattern(".git", ".svn", "package.json"),
	single_file_support = true,
	settings = {
		intelephense = {
			stubs = {
				"bcmath",
				"bz2",
				"Core",
				"curl",
				"date",
				"dom",
				"fileinfo",
				"filter",
				"gd",
				"gettext",
				"hash",
				"iconv",
				"imap",
				"intl",
				"json",
				"libxml",
				"mbstring",
				"mcrypt",
				"mysql",
				"mysqli",
				"password",
				"pcntl",
				"pcre",
				"PDO",
				"pdo_mysql",
				"Phar",
				"readline",
				"regex",
				"session",
				"SimpleXML",
				"sockets",
				"sodium",
				"standard",
				"superglobals",
				"tokenizer",
				"xml",
				"xdebug",
				"xmlreader",
				"xmlwriter",
				"yaml",
				"zip",
				"zlib",
				"wordpress",
				"wordpress-stubs",
				"woocommerce-stubs",
				"acf-pro-stubs",
				"wordpress-globals",
				"wp-cli-stubs",
				"genesis-stubs",
				"polylang-stubs"
			},
		},
	},
})

-- add html support
lspconfig.html.setup(lsp)
-- add css support (removed, causes errors, until I can fix it)
-- lspconfig.css.setup(lsp)

lsp.setup()


-- completion
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	mapping = {
		['<Tab>'] = cmp_action.tab_complete(),
		['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
		['<CR>'] = cmp.mapping.confirm({select=true}),
	}
})

