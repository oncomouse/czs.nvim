# CZS = Cmdheight Zero Search

This plugin adds proper search status and monitoring (useful for [`statusline`](https://neovim.io/doc/user/options.html#'statusline') plugins) for [Neovim](https://neovim.io) when using [`cmdheight=0`](https://neovim.io/doc/user/options.html#'cmdheight').

When I say "proper," I mean behaves the way Neovim would display search information with a command line. This includes:

1. Hiding when leaving normal mode
2. Only re-displaying after returning to normal when something has changed, such as:
    1. User presses 'n' or 'N' to move to next or previous selection
    2. User enters a new search pattern
3. Handle buffer switching

## Usage

Install `czs.nvim` as you would any other plugin (`use { "oncomouse/czs.nvim" }` in [packer.nvim](https://github.com/wbthomason/packer.nvim), for instance).

There are two functions provided by `czs.nvim` for displaying search results:

1. `require("czs").display_results()` -- Will return `true` when search results should display; `false` when not.
2. `require("czs").output()` -- Returns three values:
    1. `target` -- What the user is searching for
    2. `current` -- Which result is currently selected (will show ">" + `maxcount` if current is too high)
    3. `count` -- How many total results were found (will show ">" + `maxcount` if search returned too many results)

How you use these functions depends on your [`statusline`](https://neovim.io/doc/user/options.html#'statusline') configuration, but using [heirline.nvim](https://github.com/rebelot/heirline.nvim), I have the following component in my configuration:

```lua
local Search = {
    condition = function()
        return require("czs").display_results() 
    end,
    provider = function()
        local target, current, count = require("czs").output() 
        return string.format("/%s [%s/%s]", target, current, count)
    end,
}
```
You could use something similar for any of the other plugins available for Neovim.

## Mappings

This plugin remaps [`n`](https://neovim.io/doc/user/pattern.html#n) and [`N`](https://neovim.io/doc/user/pattern.html#N). If you would prefer that to not happen, set `vim.g.czs_do_not_map = true` somewhere in your Neovim configuration. The bindings necessary for `czs.nvim` are set to [plug-bindings](https://neovim.io/doc/user/map.html#%3CPlug%3E):

* `<Plug>(czs-move-n)`
* `<Plug>(czs-move-N)`
