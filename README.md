# 🔍 Simple Zoom

A simple plugin to add a Tmux-like zoom functionality to Neovim.

TODO: screen-cast.

## ✨ Features

 - Zoom into a split similar to `<prefix>z` in Tmux
 - Toggle the zoom with a single function or mapping
 - Retain the view when toggling zoom

## 📚 Requirements

Neovim >= **0.7.0**

## 📦 Installation

You can install the plugin with your preferred package manager:

```lua
{
    "fasterius/simple-zoom.nvim",
    config = true,
}
```

## ⚙️ Configuration

`simple-zoom` comes with the following options and their respective defaults:

```lua
{
    -- Hides the tabline when zooming. This is useful if you generally don't
    -- use tabs and would like the tabline to be hidden while zoomed, while not
    -- having to set a global `vim.o.showtabline = false` elsewhere in your
    -- config. If you have `vim.o.showtabline = false` you should also set this
    -- option to false.
    hide_tabline = true
}
```

A more complete installation and configuration could look like this:

```lua
{
    "fasterius/simple-zoom.nvim",
    opts = {
        hide_tabline = true
    },
}
```

## 🚀 Usage

This plugin does not set any key mappings by default, but instead provides the
`:SimpleZoomToggle` command to toggle the zoom on or off. When toggling the zoom
a new tab is created for the current split, for which a tab-specific variable is
set. Upon toggling in a tab for which this tab-specific variable has been set,
the tab is closed. The view is stored and loaded using `mkview` and `loadview`,
respectively, which allows storage of _e.g._ cursor position, folds, _etc._

If you want to create a key map for toggling zoom, you can do something like
this:

```lua
vim.keymap.set('n', '<localleader>z', ':SimpleZoomToggle<CR>')
```

You can also access the underlying plugin function directly in a slightly more
verbose way, if you prefer:

```lua
vim.keymap.set('n', '<localleader>z', require('simple-zoom').toggle_zoom)
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
