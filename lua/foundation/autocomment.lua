--  This plugin makes commenting and uncommenting
--  easier by enabling language specific block and
--  single line comments

-- Comment signs
local hash = "# "
local slash = "\\/\\/ "
local dash = "-- "
local quote = "\" "

-- Add the file types and the corresponding comment sign
function getCommentSign (s)

	if s == ".lua" then
		return dash
	elseif s == ".py" then
		return hash
	elseif s == ".ts" then
		return slash
	elseif s == ".js" then
		return slash
	elseif s == ".tf" then
		return hash
	elseif s == ".yaml" then
		return hash
	elseif s == ".yml" then
		return hash
	elseif s == ".rs" then
		return slash 
	elseif s == ".go" then
		return slash
	elseif s == ".vim" then
		return quote
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
