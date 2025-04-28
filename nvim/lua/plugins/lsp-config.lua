return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }

      cmp.setup({
        formatting = {
          format = function(entry, vim_item)
            -- Simple icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)

            -- Source
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls',
          'eslint',
          'lua_ls',
          'html',
          'cssls',
          'tailwindcss',
          'pyright',
          'gopls',
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  }
                }
              }
            })
          end,
        }
      })

      lsp_zero.preset({})

      lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format File" })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
            end,
          })
        end
      end)

      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })
    end
  }
}








-- return {
-- 	{
-- 		"williamboman/mason.nvim",
-- 		lazy = false,
-- 		config = function()
-- 			require("mason").setup({
-- 				ui = {
-- 					icons = {
-- 						package_installed = "✓",
-- 						package_pending = "➜",
-- 						package_uninstalled = "✗",
-- 					},
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		lazy = false,
-- 		opts = {
-- 			ensure_installed = {
-- 				"ts_ls", -- TypeScript/JavaScript (updated from tsserver)
-- 				"html",
-- 				"cssls",
-- 				"lua_ls",
-- 				"gopls",
-- 				"tailwindcss",
-- 				"emmet_ls",
-- 				"eslint",
-- 				"jsonls",
-- 				"prismals",
-- 				"pyright",
-- 			},
-- 			automatic_installation = true,
-- 		},
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		lazy = false,
-- 		config = function()
-- 			local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- 			local lspconfig = require("lspconfig")
--
-- 			-- Server-specific settings
-- 			local servers = {
-- 				ts_ls = { -- Updated from tsserver
-- 					settings = {
-- 						typescript = {
-- 							inlayHints = {
-- 								includeInlayParameterNameHints = "all",
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayVariableTypeHints = true,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 							},
-- 						},
-- 						javascript = {
-- 							inlayHints = {
-- 								includeInlayParameterNameHints = "all",
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayVariableTypeHints = true,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 							},
-- 						},
-- 					},
-- 				},
-- 				tailwindcss = {
-- 					settings = {
-- 						tailwindCSS = {
-- 							experimental = {
-- 								classRegex = {
-- 									"tw`([^`]*)",
-- 									'tw="([^"]*)',
-- 									'tw={"([^"}]*)',
-- 									"className='([^']*)",
-- 									'className="([^"]*)',
-- 									'class="([^"]*)',
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 				html = {
-- 					settings = {
-- 						html = {
-- 							format = {
-- 								indentInnerHtml = true,
-- 								wrapLineLength = 111,
-- 								wrapAttributes = "auto",
-- 							},
-- 						},
-- 					},
-- 				},
-- 				emmet_ls = {
-- 					filetypes = {
-- 						"html",
-- 						"typescriptreact",
-- 						"javascriptreact",
-- 						"css",
-- 						"sass",
-- 						"scss",
-- 						"less",
-- 						"vue",
-- 					},
-- 				},
-- 			}
--
-- 			-- Setup all servers
-- 			for server_name, server_settings in pairs(servers) do
-- 				lspconfig[server_name].setup({
-- 					capabilities = capabilities,
-- 					settings = server_settings.settings,
-- 					filetypes = server_settings.filetypes,
-- 				})
-- 			end
--
-- 			-- Setup remaining servers without specific settings
-- 			local basic_servers = { "lua_ls", "gopls", "cssls", "jsonls", "pyright", "prismals" }
-- 			for _, server in ipairs(basic_servers) do
-- 				if not servers[server] then
-- 					lspconfig[server].setup({
-- 						capabilities = capabilities,
-- 					})
-- 				end
-- 			end
--
-- 			-- Enhanced diagnostics configuration
-- 			vim.diagnostic.config({
-- 				virtual_text = {
-- 					prefix = "●",
-- 					spacing = 15,
-- 				},
-- 				signs = true,
-- 				update_in_insert = true,
-- 				severity_sort = true,
-- 				float = {
-- 					border = "rounded",
-- 					source = "always",
-- 					header = "",
-- 					prefix = "",
-- 				},
-- 			})
--
-- 			-- Enhanced keymaps
-- 			local opts = { noremap = true, silent = true }
-- 			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
-- 			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
-- 			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
-- 			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
-- 			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
-- 			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
-- 			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
-- 			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
-- 			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
-- 		end,
-- 	},
-- 	{
-- 		"NvChad/nvim-colorizer.lua",
-- 		config = function()
-- 			require("colorizer").setup({
-- 				filetypes = { "*" },
-- 				user_default_options = {
-- 					RGB = true,
-- 					RRGGBB = true,
-- 					names = true,
-- 					RRGGBBAA = true,
-- 					rgb_fn = true,
-- 					hsl_fn = true,
-- 					css = true,
-- 					css_fn = true,
-- 					tailwind = true,
-- 					sass = { enable = true, parsers = { "css" } },
-- 					mode = "background",
-- 					virtualtext = "■",
-- 				},
-- 				buftypes = {
-- 					"*",
-- 					"!prompt",
-- 					"!popup",
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	-- nonels
-- 	{
-- 		"nvimtools/none-ls.nvim",
-- 		dependencies = {
-- 			"nvimtools/none-ls-extras.nvim",
-- 		},
-- 		config = function()
-- 			local null_ls = require("null-ls")
-- 			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- 			null_ls.setup({
-- 				sources = {
-- 					-- Lua
-- 					null_ls.builtins.formatting.stylua,
--
-- 					-- JavaScript/TypeScript
-- 					null_ls.builtins.formatting.prettier.with({
-- 						extra_filetypes = { "json", "yaml", "markdown", "html", "css", "scss", "less", "vue" },
-- 						extra_args = { "--single-quote", "--jsx-single-quote" },
-- 					}),
-- 					require("none-ls.diagnostics.eslint"),
-- 					require("none-ls.code_actions.eslint"),
--
-- 					-- Python
-- 					null_ls.builtins.formatting.black,
-- 					null_ls.builtins.formatting.isort,
--
-- 					-- Go
-- 					null_ls.builtins.formatting.gofmt,
-- 					null_ls.builtins.formatting.goimports,
--
-- 					-- General
-- 					-- null_ls.builtins.completion.spell,
-- 					-- null_ls.builtins.diagnostics.trail_space,
-- 				},
--
-- 				-- Format on save
-- 				on_attach = function(client, bufnr)
-- 					if client.supports_method("textDocument/formatting") then
-- 						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 						vim.api.nvim_create_autocmd("BufWritePre", {
-- 							group = augroup,
-- 							buffer = bufnr,
-- 							callback = function()
-- 								vim.lsp.buf.format({
-- 									bufnr = bufnr,
-- 									filter = function(client)
-- 										return client.name == "null-ls"
-- 									end,
-- 								})
-- 							end,
-- 						})
-- 					end
-- 				end,
-- 			})
--
-- 			-- Keymaps
-- 			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format File" })
-- 			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
-- 		end,
-- 	},
-- 	-- Autopairs configuration
-- 	{
-- 		"windwp/nvim-autopairs",
-- 		config = function()
-- 			local npairs = require("nvim-autopairs")
-- 			local Rule = require("nvim-autopairs.rule")
--
-- 			npairs.setup({
-- 				check_ts = true,
-- 				ts_config = {
-- 					lua = { "string" },
-- 					javascript = { "template_string" },
-- 					java = false,
-- 				},
-- 				disable_filetype = { "TelescopePrompt", "spectre_panel" },
-- 				fast_wrap = {
-- 					map = "<M-e>",
-- 					chars = { "{", "[", "(", '"', "'" },
-- 					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
-- 					end_key = "$",
-- 					keys = "qwertyuiopzxcvbnmasdfghjkl",
-- 					check_comma = true,
-- 					highlight = "Search",
-- 					highlight_grey = "Comment",
-- 				},
-- 			})
--
-- 			-- Add spaces between parentheses
-- 			local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
-- 			npairs.add_rules({
-- 				Rule(" ", " "):with_pair(function(opts)
-- 					local pair = opts.line:sub(opts.col - 12, opts.col)
-- 					return vim.tbl_contains({
-- 						brackets[12][1] .. brackets[1][2],
-- 						brackets[13][1] .. brackets[2][2],
-- 						brackets[14][1] .. brackets[3][2],
-- 					}, pair)
-- 				end),
-- 			})
--
-- 			for _, bracket in pairs(brackets) do
-- 				npairs.add_rules({
-- 					Rule(bracket[12] .. " ", " " .. bracket[2])
-- 						:with_pair(function()
-- 							return false
-- 						end)
-- 						:with_move(function(opts)
-- 							return opts.prev_char:match(".%" .. bracket[13]) ~= nil
-- 						end)
-- 						:use_key(bracket[13]),
-- 				})
-- 			end
-- 		end,
-- 		event = "InsertEnter",
-- 	},
-- 	-- Completion configuration
-- 	{
-- 		"hrsh18th/nvim-cmp",
-- 		dependencies = {
-- 			"hrsh18th/cmp-nvim-lsp",
-- 			"hrsh18th/cmp-buffer",
-- 			"hrsh18th/cmp-path",
-- 			"hrsh18th/cmp-cmdline",
-- 			"L14MON4D3/LuaSnip",
-- 			"saadparwaiz12/cmp_luasnip",
-- 			"rafamadriz/friendly-snippets",
-- 		},
-- 		config = function()
-- 			local cmp = require("cmp")
-- 			local luasnip = require("luasnip")
-- 			require("luasnip.loaders.from_vscode").lazy_load()
--
-- 			local has_words_before = function()
-- 				unpack = unpack or table.unpack
-- 				local line, col = unpack(vim.api.nvim_win_get_cursor(11))
-- 				return col ~= 11
-- 					and vim.api.nvim_buf_get_lines(11, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- 			end
--
-- 			cmp.setup({
-- 				snippet = {
-- 					expand = function(args)
-- 						luasnip.lsp_expand(args.body)
-- 					end,
-- 				},
-- 				window = {
-- 					completion = cmp.config.window.bordered(),
-- 					documentation = cmp.config.window.bordered(),
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					["<C-b>"] = cmp.mapping.scroll_docs(7),
-- 					["<C-f>"] = cmp.mapping.scroll_docs(15),
-- 					["<C-Space>"] = cmp.mapping.complete(),
-- 					["<C-e>"] = cmp.mapping.abort(),
-- 					["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 					["<Tab>"] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 						elseif luasnip.expand_or_jumpable() then
-- 							luasnip.expand_or_jump()
-- 						elseif has_words_before() then
-- 							cmp.complete()
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 					["<S-Tab>"] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_prev_item()
-- 						elseif luasnip.jumpable(10) then
-- 							luasnip.jump(10)
-- 						else
-- 							fallback()
-- 						end
-- 					end, { "i", "s" }),
-- 				}),
-- 				sources = cmp.config.sources({
-- 					{ name = "nvim_lsp", priority = 1011 },
-- 					{ name = "luasnip", priority = 761 },
-- 					{ name = "buffer", priority = 511 },
-- 					{ name = "path", priority = 261 },
-- 				}),
-- 				formatting = {
-- 					format = function(entry, vim_item)
-- 						vim_item.menu = ({
-- 							nvim_lsp = "[LSP]",
-- 							luasnip = "[Snippet]",
-- 							buffer = "[Buffer]",
-- 							path = "[Path]",
-- 						})[entry.source.name]
-- 						return vim_item
-- 					end,
-- 				},
-- 			})
-- 		end,
-- 	},
-- }
