vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_dockerfile', { clear = true }),
    desc = 'Set filetype for dockerfile files',
    pattern = { "[dD]ockerfile.*" },
    callback = function()
        vim.bo.filetype = 'dockerfile'
    end,
})

