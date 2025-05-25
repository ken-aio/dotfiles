-- 基本設定
vim.opt.encoding = 'utf-8'
vim.opt.compatible = false
vim.opt.backspace = '2'
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartcase = true
vim.opt.wrapscan = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.fileencodings = { 'utf-8', 'sjis', 'euc-jp', 'latin1' }
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.backup = false
vim.opt.scrolloff = 5
vim.opt.laststatus = 2
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.clipboard:append('unnamedplus')

-- listchars設定
vim.opt.listchars = {
  tab = '>-',
  trail = '-',
  nbsp = '%',
  extends = '>',
  precedes = '<'
}

-- Leader キーの設定
vim.g.mapleader = '@'
vim.keymap.set('n', '\\', '@')

-- カレントウィンドウのみ罫線を引く
vim.api.nvim_create_augroup('cch', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = 'cch',
  pattern = '*',
  command = 'set nocursorline'
})
vim.api.nvim_create_autocmd({'WinEnter', 'BufRead'}, {
  group = 'cch',
  pattern = '*',
  command = 'set cursorline'
})

-- 行末の空白文字をハイライト
vim.api.nvim_create_augroup('HighlightTrailingSpaces', { clear = true })
vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter', 'ColorScheme'}, {
  group = 'HighlightTrailingSpaces',
  pattern = '*',
  callback = function()
    vim.cmd('highlight TrailingSpaces term=underline guibg=Red ctermbg=Red')
    vim.cmd('match TrailingSpaces /\\s\\+$/')
  end
})

-- 全角スペースをハイライト
vim.api.nvim_exec([[
  function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
  endf
]], false)

-- ウィンドウ移動のキーマッピング
local window_moves = {
  ['sj'] = '<C-w>j',
  ['sk'] = '<C-w>k',
  ['sl'] = '<C-w>l',
  ['sh'] = '<C-w>h',
  ['sJ'] = '<C-w>J',
  ['sK'] = '<C-w>K',
  ['sL'] = '<C-w>L',
  ['sH'] = '<C-w>H',
  ['sn'] = 'gt',
  ['sp'] = 'gT',
  ['sr'] = '<C-w>r',
  ['s='] = '<C-w>=',
  ['sw'] = '<C-w>w',
  ['so'] = '<C-w>_<C-w>|',
  ['sO'] = '<C-w>=',
  ['sN'] = ':bn<CR>',
  ['sP'] = ':bp<CR>',
  ['st'] = ':tabnew<CR>',
  ['ss'] = ':sp<CR>',
  ['sv'] = ':vs<CR>',
  ['sq'] = ':q<CR>',
  ['sQ'] = ':bd<CR>'
}

vim.keymap.set('n', 's', '<Nop>')
for key, value in pairs(window_moves) do
  vim.keymap.set('n', key, value, { silent = true })
end

-- ウィンドウサイズの調整
vim.g.toggle_window_size = 0
vim.api.nvim_exec([[
  function! ToggleWindowSize()
    if g:toggle_window_size == 1
      exec "normal \<C-w>="
      let g:toggle_window_size = 0
    else
      :resize
      :vertical resize
      let g:toggle_window_size = 1
    endif
  endfunction
]], false)
vim.keymap.set('n', 'm', ':call ToggleWindowSize()<CR>')

-- ターミナルモードの設定
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')
vim.api.nvim_create_user_command('T', 'split | wincmd j | resize 20 | terminal <args>', { nargs = '*' })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})