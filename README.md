# fcitx.nvim

This Neovim plugin switches the IME when InsertEnter/InsertLeave events occur.

## Installation
With [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{
  "hnjae/fcitx.nvim",
  opts = { sleep = 0.13232 },
},
```

### What does sleep option do?

This option introduces a delay in switching to a non-Latin character IME. As of 2023, there is a bug in Wayland that causes peculiar behavior when typing Korean with input-text-v3 without this delay. If you encounter a similar bug, consider using this option. Without the sleep option, the IME will change immediately.

## Differences compare to [h-hg's version](https://github.com/h-hg/fcitx.nvim)

* Includes the sleep option.
* IME switching scope is window-based, not buffer-based. The same buffer in different windows will have independent IME status.
* No cmdline event handling.
* GPL3 License.
