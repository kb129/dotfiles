vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Open Oil in a floating window" })

-- smart line start
vim.keymap.set({ "n", "x", "o" }, "0", function()
    return vim.v.count > 0 and "0" or "^"
end, { expr = true, desc = "0 => first non-blank (keep count)" })

-- absolute line start
vim.keymap.set({ "n", "x", "o" }, "<leader>0", "0", { desc = "Go to absolute line start" })

-- comment toggle
vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
vim.keymap.set("x", "<leader>/", function()
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- disable space cursor movement
vim.keymap.set({ "n", "x", "o" }, "<Space>", "<Nop>", { silent = true, desc = "Disable space cursor movement" })
