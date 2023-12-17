local M={}
---@generic main_class
---@generic sub_class
---@param main main_class
---@param sub sub_class
---@return main_class|sub_class
local function include(main,sub)
 for k,v in pairs(sub) do
  main[k]=v
 end
 return main
end
M=include(M,require("hcutil.autocmd"))
M=include(M,require("hcutil.command"))
M=include(M,require("hcutil.validate"))
M=include(M,require("hcutil.class"))
M.include=include
return M
