local M = {}

---@class simple_zoom.Opts
---@field hide_tabline? boolean

-- Default configuration
---@type simple_zoom.Opts
M.opts = {
    hide_tabline = true,
}

---Setup with options and validation
---@param opts simple_zoom.Opts|nil
function M.setup(opts)
    opts = opts or {}
    vim.validate("opts", opts, "table")
    vim.validate("opts.hide_tabline", opts.hide_tabline, "boolean", true)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

-- Internal function for zooming in
local function zoom_in()
    -- Open current split in a new tab
    vim.cmd([[tab split]])

    -- Optionally hide the tabline
    if M.opts.hide_tabline then
        vim.o.showtabline = 0
    end

    -- Set tab-specific variable
    vim.api.nvim_tabpage_set_var(0, "simple-zoom", "zoom")
end

-- Internal function for zooming out
local function zoom_out()
    -- Store view to get cursor position, folds, etc.
    vim.cmd([[mkview]])

    -- Show tabline again if it was hidden
    if M.opts.hide_tabline then
        vim.o.showtabline = 1
    end

    -- Close the tab and return to the un-zoomed view
    vim.cmd([[tab close]])

    -- Load the stored view
    vim.cmd([[loadview]])
end

---Toggle the zoom state
---Checks for the tab-specific `simple-zoom` variable and calls the
---appropriate zoom function.
function M.toggle_zoom()
    if not vim.t["simple-zoom"] then
        zoom_in()
    elseif vim.t["simple-zoom"] == "zoom" then
        zoom_out()
    end
end

return M
