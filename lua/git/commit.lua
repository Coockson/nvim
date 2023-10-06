--  vim.api.nvim_create_user_command("GitCommit", function()
-- 	local Input = require("nui.input")
-- 	local event = require("nui.utils.autocmd").event
-- 
-- -- 	local handle = io.popen("python" .. "sum.py")  -- Run the Python script
-- --     local result = handle:read("*a")              -- Read the output as a string
-- --    handle:close()
-- 
-- 	local i = io.popen("pwd | python3 commit-generator.py -")
-- 	local original = i:read("*a")            -- Read the output as a string
-- 	i:close()
-- 
-- 	local result = string.gsub(original, "\n", "")
-- 
-- 	local input = Input({
-- 	  position = "50%",
-- 	  size = {
-- 		width = 75,
-- 	  },
-- 	  border = {
--  		style = "single",
-- 		text = {
-- 		  top = "[Commit Message]",
-- 		  top_align = "center",
-- 		},
-- 	  },
-- 	  win_options = {
-- 		winhighlight = "Normal:Normal,FloatBorder:Normal",
-- 	  },
-- 	}, {
-- 	  prompt = "> ",
-- 	  default_value = result,
-- 	  on_close = function()
-- 		print("Input Closed!")
-- 	  end,
-- 	  on_submit = function(value)
-- 		print("Commited: " .. value)
-- 		vim.fn.system({"git", "commit", "--no-gpg-sign", "-am", value})
-- 		vim.cmd('GitGutter')
-- 	  end,
-- 	})
-- 
-- 	-- mount/open the component
-- 	input:mount()
-- 
-- 	-- unmount component when cursor leaves buffer
-- 	input:on(event.BufLeave, function()
-- 	  input:unmount()
-- 	end)
-- 
-- 	-- close terminal with esc
-- 	input:map("n", "<esc>", function(bufnr)
--       input:unmount()
-- 	end, { noremap = true })
-- 
-- end, {})

-- vim.api.nvim_create_user_command("GitCommit", function()
--     local Input = require("nui.input")
--     local event = require("nui.utils.autocmd").event
-- 
--     local handle = vim.fn.jobstart("pwd | python3 commit-generator.py -", {
--         on_exit = function(job_id, exit_code, event)
--              if exit_code == 0 then
--                 local result = vim.fn.jobstop(job_id)
--                 result = string.gsub(result, "\n", "")
-- 
--                 local input = Input({
--                     position = "50%",
--                     size = {
--                         width = 75,
--                     },
--                     border = {
--                         style = "single",
--                         text = {
--                             top = "[Commit Message]",
--                             top_align = "center",
--                         },
--                     },
--                     win_options = {
--                         winhighlight = "Normal:Normal,FloatBorder:Normal",
--                     },
--                 }, {
--                     prompt = "> ",
--                     default_value = result,
--                     on_close = function()
--                         print("Input Closed!")
--                     end,
--                     on_submit = function(value)
--                         print("Commited: " .. value)
--                         vim.fn.system({"git", "commit", "--no-gpg-sign", "-am", value})
--                         vim.cmd('GitGutter')
--                     end,
--                 })
-- 
--                 -- mount/open the component
--                 input:mount()
-- 
--                 -- unmount component when cursor leaves buffer
--                 input:on(event.BufLeave, function()
--                     input:unmount()
--                 end)
-- 
--                 -- close terminal with esc
--                 input:map("n", "<esc>", function(bufnr)
--                     input:unmount()
--                 end, { noremap = true })
--              else
--                  print("Error running the command")
--              end
--         end,
--         stdout_buffered = true,
--         stderr_buffered = true,
--     })
-- end, {})





vim.api.nvim_create_user_command("GitCommit", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local job_id = vim.fn.jobstart("pwd | python3 commit-generator.py -", {
        on_exit = function(_, exit_code)
--             if exit_code == 0 then
                local bufnr = vim.fn.bufnr('%')
                local result = vim.fn.getbufline(bufnr, 1, '$')
                local result_str = table.concat(result, '\n')

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
                    default_value = result_str,
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
                input:map("n", "<esc>", function()
                    input:unmount()
                end, { noremap = true })
--             else
--                 print("Error running the command")
--             end
        end,
        stdout_buffered = true,
        stderr_buffered = true,
    })
end, {})

