local _ = require('nvim-lsp.types')

local M = {}

-- List all servers you support here explicitly (for clarity + safety)
---@type string[]
local servers = {
  'cssls',
  'denols',
  'emmet_language_server',
  'gopls',
  'html',
  'lua_ls',
  'nushell',
  'rust_analyzer',
  'svelte',
  'tailwindcss',
  'ts_ls',
  'zls'
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

return M
