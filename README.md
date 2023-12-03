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

This option adds a delay in switching to a non-Latin character IME. As of 2023, not having this delay exposes a bug in Wayland that triggers key repeat behavior when typing Korean via Wayland protocol (e.g., text-input-v3). If you encounter a similar bug, consider using this option. Without the sleep option, the IME will change immediately.

https://github.com/hnjae/fcitx.nvim/assets/42675338/22c8f2a1-9077-4572-9e10-07062c7ba395

## Differences compare to [h-hg's version](https://github.com/h-hg/fcitx.nvim)

* Includes the sleep option.
* IME switching scope is window-based, not buffer-based. The same buffer in different windows will have independent IME status.
* No cmdline event handling.
* GPL3 License.
