local config = require("simple-zoom.config")

describe("config", function()
    -- Reset to defaults before each tests
    before_each(function()
        config.opts = vim.deepcopy(config.defaults)
    end)

    it("has `hide_tabline` set to `true` by default", function()
        assert.is_true(config.defaults.hide_tabline)
    end)

    it("merges a valid option into config.opts", function()
        config.setup({ hide_tabline = false })
        assert.is_false(config.opts.hide_tabline)
    end)

    it("raises an error for a non-boolean `hide_tabline` value", function()
        assert.has_error(function()
            config.setup({ hide_tabline = "not-a-boolean" })
        end)
    end)

    it("keeps defaults for options not specified in setup()", function()
        config.setup({})
        assert.same(config.defaults, config.opts)
    end)

    it("keeps defaults when setup() is called with no arguments", function()
        config.setup()
        assert.same(config.defaults, config.opts)
    end)

    it("raises an error for a non-table opts argument", function()
        assert.has_error(function()
            config.setup("not a table")
        end)
    end)
end)
