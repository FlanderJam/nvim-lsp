local _ = require('nvim-lsp.types')

---@param deps Deps
---@return ServerSettings
return function(deps)
  ---@type ServerSettings
  local server_settings = {
    meta_details = {
      ensure_installed = false, -- don't use zls from mason if targeting the nightly builds
    },
    server_config = {
      -- omit the following line if `zls` is in your PATH
      cmd = { '/opt/zig/zls/zls' }, -- This zls should be updated when you update your zig nightly
      -- There are two ways to set config options:
      --   - edit your `zls.json` that applies to any editor that uses ZLS
      --   - set in-editor config options with the `settings` field below.
      --
      -- Further information on how to configure ZLS:
      -- https://zigtools.org/zls/configure/
      settings = {
	zls = {
	  -- Whether to enable build-on-save diagnostics
	  --
	  -- Further information about build-on save:
	  -- https://zigtools.org/zls/guides/build-on-save/
	  -- enable_build_on_save = true,

	  -- Neovim already provides basic syntax highlighting
	  semantic_tokens = "partial",

	  -- omit the following line if `zig` is in your PATH
	  -- zig_exe_path = '/path/to/zig_executable' -- zig is on the path
	}
      }
    }
  }

  return server_settings
end
