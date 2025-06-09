local _ = require('nvim-lsp.types')

---@param deps Deps
---@return ServerSettings
return function(deps)
  ---@type ServerSettings
  local server_settings = {
    meta_details = {
      ensure_installed = false, -- nu isn't on mason, so we don't want to force install it
    },
    server_config = {
      cmd = { "nu", "--lsp" }, -- This pulls the lsp from the nu command running on the shell
      filetypes = { "nu" },
      single_file_support = true,
    }
  }

  return server_settings
end
