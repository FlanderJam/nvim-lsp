local _ = require("nvim-lsp.types")

local T = {
	language_servers = {
		cssls = {},
		denols = {},
		emmet_language_server = {},
		gopls = {},
		html = {},
		lua_ls = {},
		nushell = {},
		rust_analyzer = {},
		svelte = {},
		tailwindcss = {},
		ts_ls = require("nvim-lsp.servers.ts_ls")(deps),
		zls = {},
		["eslint-lsp"] = {},
	},
	formatters_by_ft = {
		lua = { "stylua", { name = "testy_westy" } },
		typescript = { { name = "prettierd", install_only = true } },
		javascript = { { name = "prettierd", install_only = true } },
	},
	linters_by_ft = {
		typescript = { { name = "eslint_d", install_only = true } },
		javascript = { { name = "eslint_d", install_only = true } },
	},
	dap_by_ft = {},
}

function remove_duplicates(array)
	local hash = {}
	local dupes_removed = {}
	for _, value in ipairs(array) do
		if not hash[value] then
			hash[value] = true
			table.insert(dupes_removed, value)
		end
	end
	return dupes_removed
end

function T:get_servers_list()
	local servers_list = {}
	for server, _ in pairs(self.language_servers) do
		table.insert(servers_list, server)
	end
	return remove_duplicates(servers_list)
end

function T:get_servers() end

function T:get_formatters_list()
	local formatters = {}
	for _, language_formatters in pairs(self.formatters_by_ft) do
		for _, language_formatter in ipairs(language_formatters) do
			if type(language_formatter) == "string" then
				table.insert(formatters, language_formatter)
			elseif type(language_formatter.name) == "string" then
				table.insert(formatters, language_formatter.name)
			end
		end
	end
	return remove_duplicates(formatters)
end

function T:get_linters_list()
	local linters = {}
	for _, language_linters in pairs(self.linters_by_ft) do
		for _, language_linter in ipairs(language_linters) do
			if type(language_linter) == "string" then
				table.insert(linters, language_linter)
			elseif type(language_linter.name) == "string" then
				table.insert(linters, language_linter.name)
			end
		end
	end
	return remove_duplicates(linters)
end

local M = {}

-- List all servers you support here explicitly (for clarity + safety)
---@type string[]
local servers = {
	"cssls",
	"denols",
	"emmet_language_server",
	"gopls",
	"html",
	"lua_ls",
	"nushell",
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"ts_ls",
	"zls",
	"eslint-lsp",
}

-- Optional: Allow passing shared deps (like lspconfig, capabilities, etc.)
---@param deps Deps
---@return ServerConfigMap
function M.get_servers(deps)
	---@type ServerConfigMap
	local configs = {}

	for _, server in ipairs(servers) do
		local ok, mod = pcall(require, "nvim-lsp.servers." .. server)
		if ok and type(mod) == "function" then
			---@type ServerConfig
			local config = mod(deps)
			configs[server] = config
		else
			vim.notify("Failed to load LSP config for: " .. server, vim.log.levels.WARN)
		end
	end

	return configs
end

function M.get_linters(deps) end

function M.get_formatters(deps) end

function M.get_debuggers(deps) end

return M
