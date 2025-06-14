---@class util
---@field root_pattern (fun(...: any): function)|nil

---@class lspconfig
---@field util util|nil
---
---@class ServerSettings
---@field server_config ServerConfig
---@field meta_details ServerMetaDetails
---
---
---@class ServerMetaDetails
---@field ensure_installed boolean
---@field skip_mason boolean

---@class ServerConfig
---@field root_dir fun(bufnr: any, on_dir: any)|nil
---@field single_file_support boolean|nil
---@field settings table|nil

---@class Deps
---@field lspconfig lspconfig|nil
---@field capabilities any|nil
---@field on_attach any|nil

---@alias ServerConfigMap table<string, ServerSettings>
