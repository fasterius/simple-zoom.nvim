# Changelog

## [1.2.0]

### Added

- Support for configuration via `vim.g.simple_zoom` for use with e.g. the
  built-in `vim.pack` plugin manager.

## [1.1.2]

### Changed

- The tab-specific `simple-zoom` variable set when zoomed in is now a table
  instead of the string `"zoom"`; statusline or other integrations reading it
  directly (see the _Extras_ section in `README.md`) should use
  `type(vim.t["simple-zoom"]) == "table"` instead of comparing it to `"zoom"`.

### Fixed

- The previous value of `showtabline` is now restored after zooming out (if
  it had been set by _e.g._ user configuration beforehand) instead of always
  being reset to `1`.
- Zooming in on a buffer without a file name (_e.g._ a scratch, quickfix or
  terminal buffer) no longer raises an `E32: No file name` error and leaves
  the plugin stuck in a zoomed-in state.

## [1.1.1]

### Fixed

- Corrected the minimum required Neovim version to 0.11.0.

## [1.1.0]

### Added

- Health-check module (`lua/simple-zoom/health.lua`), reporting on the Neovim
  version requirement and flagging unrecognised `setup()` options via
  `:checkhealth simple-zoom`.

### Changed

- Restructured the plugin into `lua/simple-zoom/init.lua`; `setup()` options are
  now validated with `vim.validate()` and documented with LuaCATS annotations.
- `:SimpleZoomToggle` is now registered lazily from `plugin/simple-zoom.lua`,
  guarded against double-loading, so it exists at start-up without requiring
  `setup()` to be called first.
- Renamed `LICENSE` to `LICENCE`.
- Restructured `doc/simple-zoom.nvim.txt` with dedicated Requirements, Commands
  and Keymaps sections; reordered the README sections to match.

### Fixed

- Fixed a broken keymap example in the help docs that called `toggle_zoom()`
  instead of passing the function reference.

## [1.0.1]

### Fixed

- Use `0`/`1` instead of `true`/`false` for `showtabline`, which gave an error
  on Neovim 0.10 (#1).

## [1.0.0]

### Added

- Initial stable release: Tmux-like zoom toggle via `:SimpleZoomToggle` and
  `toggle_zoom()`, the `hide_tabline` configuration option, and
  statusline-integration guidance.
