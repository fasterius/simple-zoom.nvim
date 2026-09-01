# Changelog

## [1.1.0] 2026-09-01

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

## [1.0.1] - 2024-06-01

### Fixed

- Use `0`/`1` instead of `true`/`false` for `showtabline`, which gave an error
  on Neovim 0.10 (#1).

## [1.0.0] - 2024-03-19

### Added

- Initial stable release: Tmux-like zoom toggle via `:SimpleZoomToggle` and
  `toggle_zoom()`, the `hide_tabline` configuration option, and
  statusline-integration guidance.
