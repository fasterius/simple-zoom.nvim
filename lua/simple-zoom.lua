local M = {}

-- Default configuration
M.opts = {
    hide_tabline = true,
    center_view = true
}

-- TODO: This should work with (1) no user-config or (2) user supplies both
-- config variables, but not if the user only supplies one config variable.
function M.setup(opts)
    M.opts = vim.tbl_extend("force", M.opts, opts or {})
end

function M.zoom_in()
    -- Open current split in a new tab
    vim.cmd[[tab split]]

    -- Optionally hide the tabline
    if M.opts.hide_tabline then
        vim.o.showtabline = false
    end

    -- Set tab-specific variable
    -- TODO: Should this be done using something different, like a
    -- plugin-specific value? Using a tab-specific value is good for cases of
    -- moving between tabs, even if that is not my use-case.
    vim.api.nvim_tabpage_set_var(0, 'simple-zoom', 'zoom')
    print('zoomed in')
end

function M.zoom_out()
    -- Store view to get cursor position, folds, etc.
    vim.cmd[[mkview]]

    -- Show tabline again if it was hidden
    -- TODO: Get the current setting for showtabline and restore that
    if M.opts.hide_tabline then
        vim.o.showtabline = true
    end

    -- Close the tab and return to the un-zoomed view
    vim.cmd[[tab close]]

    -- Load the stored view
    vim.cmd[[loadview]]

    -- Optionally center the view vertically
    if M.opts.center_view then
        vim.cmd[[normal! zz]]
    end
    print('zoomed out')
end

function M.toggle_zoom()
    -- Check for the tab-specific 'zoom' variable, indicating whether the
    -- current split is in a zoomed state or not
    if not vim.t['simple-zoom'] then
        M.zoom_in()
    elseif vim.t['simple-zoom'] == 'zoom' then
        M.zoom_out()
    end
end

-- Development keymap
-- TODO: remove this and add in actual Neovim config
vim.keymap.set('n', '<localleader>z', M.toggle_zoom)

return M