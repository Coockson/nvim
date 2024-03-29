vim.api.nvim_create_user_command("GitCommit", function()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local input = Input({
	  position = "50%",
	  size = {
		width = 75,
	  },
	  border = {
 		style = "single",
		text = {
		  top = "[Commit Message]",
		  top_align = "center",
		},
	  },
	  win_options = {
		winhighlight = "Normal:Normal,FloatBorder:Normal",
	  },
	}, {
	  prompt = "> ",
	  default_value = "feat: ",
	  on_close = function()
		print("Input Closed!")
	  end,
	  on_submit = function(value)
		print("Commited: " .. value)
		vim.fn.system({"git", "commit", "-am", value})
		vim.cmd('GitGutter')
	  end,
	})

	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
	  input:unmount()
	end)

	-- close terminal with esc
	input:map("n", "<esc>", function(bufnr)
      input:unmount()
	end, { noremap = true })

end, {})
