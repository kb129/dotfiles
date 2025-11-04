require("base")
require("autocmds")
require("options")
require("keymaps")
require("colorscheme")
require("plugins")
-- Plugin configurations
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        natural_sorting = true,
    },
    float = {
        padding = 2,
        max_width = 0.9,
        max_height = 0.9,
        border = "rounded",
        win_options = {
            winblend = 10,
        },
    },
})
