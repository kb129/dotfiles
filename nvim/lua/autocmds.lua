local function exe(cmd)
    return vim.fn.executable(cmd) == 1
end

local function filter_with_view(cmdline, not_found_msg)
    local cmd = vim.split(cmdline, "%s+")[1]:gsub("%%!", "")
    if not exe(cmd) then
        vim.notify(not_found_msg, vim.log.levels.ERROR)
        return
    end

    local view = vim.fn.winsaveview()

    local ok, err = pcall(function()
        vim.cmd("silent keepjumps keepalt " .. cmdline)
    end)

    vim.fn.winrestview(view)

    if not ok then
        vim.notify("Format error: " .. tostring(err), vim.log.levels.ERROR)
    end
end

-- formatters on save
-- python
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        filter_with_view([[%!black --quiet -]], [[Error: 'black' not found. Install with: pip install black]])
    end,
})
-- shell
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.sh", "*.bash", "*.zsh" },
    callback = function()
        filter_with_view(
            [[%!shfmt -i 2 -ci -bn -]],
            [[Error: 'shfmt' not found. Install with: brew install shfmt (or your pkg manager)]]
        )
    end,
})
-- lua
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function()
        filter_with_view(
            [[%!stylua -]],
            [[Error: 'stylua' not found. Install with: brew install stylua (or your pkg manager)]]
        )
    end,
})
-- html, css, js, json
-- html
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.html", "*.htm" },
    callback = function()
        filter_with_view(
            [[%!tidy -q -i --indent-spaces 2 --wrap 0]],
            [[Error: 'tidy' not found. Install with: brew install tidy-html5 (or your pkg manager)]]
        )
    end,
})

-- replace tabs with spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        -- Makefileはタブが必須なので除外
        if vim.bo.filetype == "make" then
            return
        end

        local view = vim.fn.winsaveview()
        vim.cmd([[silent! %s/\t/    /g ]])

        vim.fn.winrestview(view)
    end,
})

-- no comment lines at new lines
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.cmd([[ setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]])
    end,
})

-- make dir if not exists on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(event)
        local file = event.match or vim.fn.expand("<afile>")
        local dir = vim.fn.fnamemodify(file, ":h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- check for external file changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })

-- Makefile用設定：タブを保持
vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

local group = vim.api.nvim_create_augroup("AutoRead", { clear = true })

-- Check file changes when returning to Neovim or entering a buffer
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose" }, {
    group = group,
    callback = function()
        -- Only check for changes if we can safely do so
        -- (checktime itself is safe; unsaved buffers won't be auto-reloaded)
        vim.cmd("checktime")
    end,
})

-- Notify after a file was reloaded because it changed outside Neovim
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = group,
    callback = function(args)
        -- args.file: changed file path (may be empty depending on situation)
        local name = args.file ~= "" and vim.fn.fnamemodify(args.file, ":~:.") or "current buffer"
        vim.notify(("Reloaded: %s (changed outside)"):format(name), vim.log.levels.INFO)
    end,
})
