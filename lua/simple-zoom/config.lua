local M = {}

---@class simple_zoom.Opts
---@field hide_tabline? boolean

-- Default configuration.
---@type simple_zoom.Opts
M.defaults = {
    hide_tabline = true,
}
M.opts = vim.deepcopy(M.defaults)

---Setup with options and validation
---@param opts simple_zoom.Opts|nil
function M.setup(opts)
    opts = opts or {}
    vim.validate("opts", opts, "table")
    vim.validate("opts.hide_tabline", opts.hide_tabline, "boolean", true)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

return M
