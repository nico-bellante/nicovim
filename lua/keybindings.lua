vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap

-- Moving Between Buffers
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = false })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = false })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = false })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = false })

map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

map("n", "\\f", "<cmd> Telescope live_grep<CR>", { noremap = true, silent = false })
map("n", "\\\\", "<cmd> Telescope find_files<CR>", { noremap = true, silent = false })

map("n", "<leader><leader>", "<cmd> Telescope <CR>", { noremap = true, silent = false })

-- open corresponding css modules
map("n", "<leader>cm", "<cmd> :vsplit %<.module.css <CR>", { noremap = true, silent = false })

map("n", "gd", "<cmd>lua vim.lsp.buf.definition() <CR>", { noremap = true, silent = false })
