-- This autocommand refreshes the buffer when the code changes in the disk.
-- Example cases: linters, other editors changes etc..


vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
