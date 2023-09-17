-- Creates a new window with a terminal instance

vim.api.nvim_create_user_command("BufTerminal", function()
	command = [[
		new
		res 15
		terminal
	]]
	vim.cmd(command) 
end, {})
