-- Don't load more than once
if vim.g.loaded_simple_zoom then
    return
end
vim.g.loaded_simple_zoom = 1

-- Check Neovim version requirement
if vim.fn.has("nvim-0.11.0") ~= 1 then
    vim.notify("simple-zoom.nvim requires at least Neovim v0.11.0.", vim.log.levels.ERROR)
    return
end

-- Create user command
vim.api.nvim_create_user_command("SimpleZoomToggle", function()
    require("simple-zoom").toggle_zoom()
end, { desc = "Toggle Simple Zoom on and off" })
