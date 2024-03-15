# Simple Zoom

A simple plugin to add a Tmux-like zoom functionality to Neovim.

TODO: screen-cast.

## Features

 - Zoom into a split similar to `<prefix>z` in Tmux
 - Toggle the zoom with a single function or mapping
 - Retain the view when toggling zoom

## Requirements

TODO

## Installation

You can install the plugin with your preferred package manager:

```lua
{
    "fasterius/simple-zoom.nvim",
    config = true,
}
```

## Configuration

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

## Usage

TODO

## About

`simple-zoom` is very simple. When toggling the zoom a new tab is created for
the current split, for which a tab-specific variable is set. Upon toggling in a
tab for which this tab-specific variable has been set, the tab is closed. The
view is stored and loaded using `mkview` and `loadview`, respectively, which
allows storage of _e.g._ cursor position, folds, _etc._
