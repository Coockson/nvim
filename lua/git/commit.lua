 vim.api.nvim_create_user_command("GitCommit", function()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

-- 	local handle = io.popen("python" .. "sum.py")  -- Run the Python script
--     local result = handle:read("*a")              -- Read the output as a string
--    handle:close()

	local code_path = vim.fn.expand('%:p') 
--  	vim.cmd("cd /Users/dkMuKhCo/.config/nvim")

	local i = io.popen("pwd | python3 /Users/dkMuKhCo/.config/nvim/commit-generator.py -")
	local original = i:read("*a")            -- Read the output as a string
	i:close()

	local result = string.gsub(original, "\n", "")

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
	  default_value = result,
	  on_close = function()
		print("Input Closed!")
	  end,
	  on_submit = function(value)
		print("Commited: " .. value)
		vim.fn.system({"git", "commit", "--no-gpg-sign", "-am", value})
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

