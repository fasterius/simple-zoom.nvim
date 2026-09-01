if vim.fn.has("nvim-0.7.0") ~= 1 then
    vim.api.nvim_err_writeln("simple-zoom.nvim requires at least Neovim v0.7.0.")
end

-- Create user command
vim.api.nvim_create_user_command("SimpleZoomToggle", function()
    require("simple-zoom").toggle_zoom()
end, { desc = "Toggle Simple Zoom on and off" })
