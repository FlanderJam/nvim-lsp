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

  return server_settings
end
