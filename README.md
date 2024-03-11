![Screenshot from 2024-03-12 02-16-59](https://github.com/shreyas-a-s/neodarker.nvim/assets/137637016/baaa6d60-500d-4565-bf38-0af250222e5e)

### About

A clean dark theme written in lua for neovim (0.7.2 or older).

### Features

- Support for numerous plugins
- Customizable

### Installation

Install with your favorite package manager:

[lazy](https://github.com/folke/lazy.nvim)

``` lua
{
    "shreyas-a-s/neodarker.nvim",
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("neodarker").setup(opts) -- calling setup is optional
        vim.cmd.colorscheme("neodarker")
    end,
}
```

### Default configuration

```lua
{
    transparent_background = false, -- set background to transparent
    gamma = 1.00, -- adjust the brightness of the theme
    styles = {
        comments = { italic = false }, -- style for comments
        keywords = { italic = false }, -- style for keywords
        identifiers = { italic = false }, -- style for identifiers
        functions = {}, -- style for functions
        variables = {}, -- style for variables
    },
    custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
    custom_palette = {} or function(palette) return {} end, -- extend palette
    terminal_colors = true, -- enable terminal colors
}
```

### Acknowledgements

- This colorscheme repo is forked from [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim).
