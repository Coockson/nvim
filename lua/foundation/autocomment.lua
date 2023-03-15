--  This plugin makes commenting and uncommenting 
--  easier by enabling language specific block and
--  single line comments

local py = "# "
local ts = "\\/\\/ "
local lua = "-- "
local tf = "# "

function getCommentSign (s)

	if s == ".lua" then
		return lua
	elseif s == ".py" then
		return py
	elseif s == ".ts" then
		return ts
	elseif s == ".js" then
		return py
	elseif s == ".tf" then
		return tf
	end
end

vim.api.nvim_create_user_command("AutoComment", function()
	line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
	line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
	fileType = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$")
	commentSign = getCommentSign(fileType)
 	command = string.format([[
 		%d,%ds/^/%s/
 		noh
 	]], line1, line2, commentSign)
 	vim.cmd(command)

end, {})

vim.api.nvim_create_user_command("AutoUncomment", function()
	line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
	line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
	fileType = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$")

	commentSign = getCommentSign(fileType)

 	command = string.format([[
 		%d,%ds/%s//
 		noh
 	]], line1, line2, commentSign)
 	vim.cmd(command)

end, {})

vim.api.nvim_create_user_command("CommentSingleLine", function()
	fileType = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$")

	commentSign = getCommentSign(fileType)

 	command = string.format([[
 		s/^/%s/
 		noh
 	]], commentSign)
 	vim.cmd(command)

end, {})

vim.api.nvim_create_user_command("UncommentSingleLine", function()
	fileType = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$")

	commentSign = getCommentSign(fileType)

 	command = string.format([[
 		s/%s//
 		noh
 	]], commentSign)
 	vim.cmd(command)

end, {})
