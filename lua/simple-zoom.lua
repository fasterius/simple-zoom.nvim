local M = {}

-- Default configuration
M.opts = {
    hide_tabline = true,
}

-- Setup with options
function M.setup(opts)
    M.opts = vim.tbl_extend("force", M.opts, opts or {})
end

-- Internal function for zooming in
local function zoom_in()
    -- Open current split in a new tab
    vim.cmd([[tab split]])

    -- Optionally hide the tabline
    if M.opts.hide_tabline then
        vim.o.showtabline = false
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
        vim.o.showtabline = true
    end

    -- Close the tab and return to the un-zoomed view
    vim.cmd([[tab close]])

    -- Load the stored view
    vim.cmd([[loadview]])
end

-- Main function to toggle zoom state
function M.toggle_zoom()
    -- Check for tab-specific variable and call the appropriate zoom function
    if not vim.t["simple-zoom"] then
        zoom_in()
    elseif vim.t["simple-zoom"] == "zoom" then
        zoom_out()
    end
end

-- Add `SimpleZoomToggle` user command
vim.api.nvim_create_user_command("SimpleZoomToggle", M.toggle_zoom, { desc = "Toggle Simple Zoom on and off" })

return M
