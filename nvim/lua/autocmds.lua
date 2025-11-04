local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
local grp = augroup("TabsToSpacesOnWrite", { clear = true })

autocmd("BufWritePre", {
    group = grp,
    pattern = "*",
    callback = function(args)
        local bufnr = args.buf
        if vim.bo[bufnr].filetype == "make" then return end
        if vim.bo[bufnr].buftype ~= "" then return end
        if vim.fn.search("\\t", "nw") == 0 then return end
        local prev_expandtab = vim.bo[bufnr].expandtab
        local prev_tabstop   = vim.bo[bufnr].tabstop

        vim.bo[bufnr].expandtab = true
        vim.bo[bufnr].tabstop   = 4
        vim.cmd("silent keepjumps keepmarks %retab")

        vim.bo[bufnr].expandtab = prev_expandtab
        vim.bo[bufnr].tabstop   = prev_tabstop
    end,
})
