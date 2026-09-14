local M = {}

local config = require("simple-zoom.config")

---Setup with user options
---@param opts simple_zoom.Opts | nil
function M.setup(opts)
    config.setup(opts)
end

-- Internal function for zooming in
local function zoom_in()
    -- Remember the current `showtabline` value
    local showtabline = vim.o.showtabline

    -- Open current split in a new tab
    vim.cmd([[tab split]])

    -- Optionally hide the tabline
    if config.opts.hide_tabline then
        vim.o.showtabline = 0
    end

    -- Set tab-specific variable to previously remembered `showtabline`
    vim.api.nvim_tabpage_set_var(
        0,
        "simple-zoom",
        { showtabline = showtabline }
    )
end

-- Internal function for zooming out
local function zoom_out()
    -- Store view to get cursor position, folds, etc.
    vim.cmd([[mkview]])

    -- Restore the `showtabline` value from before zooming in, as applicable
    if config.opts.hide_tabline then
        vim.o.showtabline = vim.t["simple-zoom"].showtabline
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
    elseif type(vim.t["simple-zoom"]) == "table" then
        zoom_out()
    end
end

return M
