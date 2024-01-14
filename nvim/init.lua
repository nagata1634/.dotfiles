-- タブをスペースに変更
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- VimLeave イベントでスワップファイルを削除
vim.cmd[[
  augroup RemoveSwapFile
    autocmd!
    autocmd VimLeave * silent !rm -f %:p:h/.%:t
  augroup END
]]
