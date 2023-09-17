vim.api.nvim_create_user_command("GitCommit", function()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local input = Input({
	  position = "50%",
	  size = {
		width = 30,
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
	  default_value = "",
	  on_close = function()
		print("Input Closed!")
	  end,
	  on_submit = function(value)
		print("Input Submitted: " .. value)
		vim.fn.system({"git", "commit", "-am", value})
	  end,
	})

	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
	  input:unmount()
	end)
end, {})
