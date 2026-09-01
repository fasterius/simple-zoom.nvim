local M = {}

-- The complete list of known configuration keys.
local known_opts = {
    hide_tabline = true,
}

---Run simple-zoom's healthcheck
---Report on the presence of the plugin's requirements, and flag any
---unrecognised configuration key set via `setup()`.
function M.check()
    vim.health.start("simple-zoom.nvim")

    if vim.fn.has("nvim-0.10.0") == 1 then
        vim.health.ok("Neovim version is >= 0.10.0")
    else
        vim.health.error("Neovim version is too old", "simple-zoom.nvim requires at least Neovim v0.10.0")
    end

    local opts = require("simple-zoom").opts
    local unknown = {}
    for key in pairs(opts) do
        if not known_opts[key] then
            table.insert(unknown, key)
        end
    end
    if #unknown == 0 then
        vim.health.ok("No unrecognised configuration options")
    else
        vim.health.warn(
            "Unrecognised configuration option(s): " .. table.concat(unknown, ", "),
            "Check for typos; see |simple-zoom.configuration| for the supported options"
        )
    end
end

return M
