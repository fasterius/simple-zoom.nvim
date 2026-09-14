local simple_zoom = require("simple-zoom")
local config = require("simple-zoom.config")

describe("toggle_zoom", function()
    local file

    before_each(function()
        -- Reset config for each test
        config.opts = vim.deepcopy(config.defaults)

        -- Give a baseline different from what the plugin sets for `showtabline`
        vim.o.showtabline = 2

        -- Create a real file for each test, needed for `mkview` to work
        file = vim.fn.tempname()
        vim.cmd("edit " .. file)
        vim.api.nvim_buf_set_lines(0, 0, -1, false, { "line one", "line two" })
        vim.cmd("silent write")
    end)

    after_each(function()
        -- Close any tabs left open by a failing test
        while #vim.api.nvim_list_tabpages() > 1 do
            vim.cmd("tabclose")
        end

        -- Clean up the buffer and remove the file
        vim.cmd("bwipeout!")
        os.remove(file)
    end)

    it("opens a new tab and marks it as zoomed", function()
        local tabs_before = #vim.api.nvim_list_tabpages()
        simple_zoom.toggle_zoom()
        assert.equal(tabs_before + 1, #vim.api.nvim_list_tabpages())
        assert.equal("zoom", vim.t["simple-zoom"])
    end)

    it("closes the zoomed tab and clears the zoom state", function()
        local tabs_before = #vim.api.nvim_list_tabpages()
        simple_zoom.toggle_zoom()
        simple_zoom.toggle_zoom()
        assert.equal(tabs_before, #vim.api.nvim_list_tabpages())
        assert.is_nil(vim.t["simple-zoom"])
    end)

    it("hides the tabline on zoom in when `hide_tabline` is true", function()
        config.opts.hide_tabline = true
        simple_zoom.toggle_zoom()
        assert.equal(0, vim.o.showtabline)
    end)

    it(
        "restores the tabline on zoom out when `hide_tabline` is true",
        function()
            config.opts.hide_tabline = true
            simple_zoom.toggle_zoom()
            simple_zoom.toggle_zoom()
            assert.equal(1, vim.o.showtabline)
        end
    )

    it("leaves the tabline untouched when `hide_tabline` is false", function()
        config.opts.hide_tabline = false
        simple_zoom.toggle_zoom()
        assert.equal(2, vim.o.showtabline)
        simple_zoom.toggle_zoom()
        assert.equal(2, vim.o.showtabline)
    end)

    it(
        "reads `hide_tabline` at call time rather than at zoom-in time",
        function()
            config.opts.hide_tabline = true
            simple_zoom.toggle_zoom()
            assert.equal(0, vim.o.showtabline)
            -- Flip the option to false after zooming in, before zooming out
            config.opts.hide_tabline = false
            simple_zoom.toggle_zoom()
            -- Check that the tabline is still hidden after option flip
            assert.equal(0, vim.o.showtabline)
        end
    )

    it("preserves the cursor position when zooming out", function()
        simple_zoom.toggle_zoom()
        vim.api.nvim_win_set_cursor(0, { 2, 1 })
        simple_zoom.toggle_zoom()
        assert.equal(2, vim.api.nvim_win_get_cursor(0)[1])
    end)

    it("does nothing when the tab-scoped variable is unrecognised", function()
        vim.api.nvim_tabpage_set_var(0, "simple-zoom", "not-zoom")
        local tabs_before = #vim.api.nvim_list_tabpages()
        simple_zoom.toggle_zoom()
        assert.equal(tabs_before, #vim.api.nvim_list_tabpages())
        vim.api.nvim_tabpage_del_var(0, "simple-zoom")
    end)
end)
