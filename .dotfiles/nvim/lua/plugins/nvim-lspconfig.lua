return {
    "neovim/nvim-lspconfig",
    config = function()
        require('lsp.basedpyright')
        require('lsp.superhtml')
        require('lsp.emmet_language_server')
        require('lsp.svelte')
        require('lsp.cssls')
        vim.lsp.enable('basedpyright')
        vim.lsp.enable('superhtml')
        vim.lsp.enable('emmet_language_server')
        vim.lsp.enable('svelte')
        vim.lsp.enable('cssls')
    end
}
