require("base")
require("autocmds")
require("options")
require("colorscheme")
require("plugins")
require("keymaps")
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
    keymaps = {
        ["<C-h>"] = "actions.parent",
        ["<leader>|"] = "actions.select_vsplit",
        ["<leader>-"] = "actions.select_split",
        ["<leader>t"] = "actions.select_tab",
        ["<C-r>"] = "actions.refresh",
        ["q"] = "actions.close",
    },
})
