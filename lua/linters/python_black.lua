-- This autocommand lints python files after saving and refreshes the page.
-- Uses black linter


vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("py_linter", { clear = true }),
	pattern = "*.py",
	callback = function()
		vim.fn.jobstart({"black", vim.api.nvim_buf_get_name(0)},{
			stdout_buffered = true,
			on_stdout = function(_, data)
				vim.api.nvim_command('checktime')
			end
		})
	end,
})

