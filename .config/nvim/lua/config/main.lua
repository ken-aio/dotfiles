-- 診断表示の設定
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- LSPの共通設定
local M = {}

M.on_attach = function(client, bufnr)
  -- キーマッピングの設定
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gx', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', 'gf', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- LSPの機能設定
M.handlers = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
    }
  ),
}

return M