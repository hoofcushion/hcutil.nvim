local M={}
function M.create_user_commands(commands)
 for i=1,#commands do
  local name,func,opts=unpack(commands[i])
  vim.api.nvim_create_user_command(name,func,opts)
 end
end
function M.del_user_commands(commands)
 for i=1,#commands do
  vim.api.nvim_del_user_command(commands[i][1])
 end
end
return M