local _ = require('nvim-lsp.types')

---@param deps Deps
---@return ServerSettings
return function(deps)
  ---@type ServerSettings
  local server_settings = {
    meta_details = {
      ensure_installed = false,
    },
    server_config = {}
  }


  ---@type ServerConfig
  local config = {
    single_file_support = false,
    settings = {},
  }

  if deps.lspconfig ~= nil then
    ---@type lspconfig
    local lspconfig = deps.lspconfig
    config.root_dir = function(bufnr, on_dir)
      local match = lspconfig.util.root_pattern('package.json')(bufnr)
      local deno_match = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deno.lock')(bufnr)
      if match ~= nil and deno_match == nil then
	on_dir(match)
      end
    end
  end

  server_settings.server_config = config

  return server_settings
end
