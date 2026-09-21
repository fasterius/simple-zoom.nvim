# 🔍 Simple Zoom

A simple plugin to add a Tmux-like zoom functionality to Neovim.

https://github.com/fasterius/simple-zoom.nvim/assets/12528765/354e67fa-5bc0-4aae-a41d-5f0440de21ff

## ✨ Features

- Zoom into a split similar to `<prefix>z` in Tmux
- Toggle the zoom with a single command or mapping
- Retain the view when toggling zoom
- Can be integrated into the statusline

## 📚 Requirements

Neovim >= **0.11.0**

## 📦 Installation

You can install the plugin with your preferred package manager:

```lua
-- vim.pack
vim.pack.add({
    "https://github.com/fasterius/simple-zoom.nvim",
})
```

```lua
-- lazy.nvim
{
    "fasterius/simple-zoom.nvim",
}
```

## 🚀 Usage

This plugin does not set any key mappings by default, but instead provides the
`:SimpleZoomToggle` command or the `toggle_zoom` Lua function to toggle the zoom
on or off. When toggling the zoom a new tab is created for the current split,
for which a tab-specific variable is set. Upon toggling in a tab for which this
tab-specific variable has been set, the tab is closed. The view is stored and
loaded when appropriate, which allows maintaining _e.g._ cursor position, folds,
_etc._

If you want to create a key map for toggling zoom, you can do something like
this:

```lua
vim.keymap.set('n', '<localleader>z', '<CMD>SimpleZoomToggle<CR>')
```

You can also access the underlying plugin function directly:

```lua
vim.keymap.set('n', '<localleader>z', require('simple-zoom').toggle_zoom)
```

## ⚙️ Configuration

`simple-zoom` comes with the following options and their respective defaults:

```lua
{
    -- Hides the tabline when zooming. This is useful if you generally don't
    -- use tabs and would like the tabline to be hidden while zoomed, while not
    -- having to set a global `vim.o.showtabline = false` elsewhere in your
    -- config.
    hide_tabline = true
}
```

A more complete installation and configuration could look like this:

```lua
-- vim.pack
vim.pack.add({
    "https://github.com/fasterius/simple-zoom.nvim",
})
vim.g.slime_peek = {
    hide_tabline = true,
}
```

```lua
-- lazy.nvim
{
    "fasterius/simple-zoom.nvim",
    opts = {
        hide_tabline = true
    },
}
```

## 🔥 Extras

Since Simple Zoom sets a tab-specific variable (a table) when zoomed in, it is
possible to use this variable to set _e.g._ a statusline element to show when
zoom is toggled. For example, this is how it could be done using the popular
[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) plugin (the results
of which are shown in the demo above):

```lua
local function is_zoomed_in()
    if not vim.t["simple-zoom"] then
        return ''
    elseif type(vim.t["simple-zoom"]) == "table" then
        return '󰍉'
    end
end

require("lualine").setup {
    ...
    sections = {
        lualine_a = {
            { "filename" },
            { is_zoomed_in },
        }
    }
    ...
}
```

## 📕 About

`simple-zoom` is very simple.

The aim of this plugin is to emulate the Tmux zoom functionality and nothing
else, without extra functionality or additional bells and whistles. There are
several other Neovim plugins that has similar functionality to `simple-zoom`,
but that are also more fully-featured:

- [focus.nvim](https://github.com/nvim-focus/focus.nvim)
- [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)
- [true-zen.nvim](https://github.com/pocco81/true-zen.nvim)
- [NeoZoom.lua](https://github.com/nyngwang/NeoZoom.lua/tree/main)

If you only care about the Tmux-like zoom functionality, `simple-zoom` is for
you! If you are looking for something with additional features I recommend
checking out the above mentioned plugins.
