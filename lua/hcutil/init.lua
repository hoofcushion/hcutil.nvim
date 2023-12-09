local M={}
local function include(modname)
 return vim.tbl_deep_extend("force",M,require(modname))
end
M=include("hcutil.autocmd")
M=include("hcutil.command")
M=include("hcutil.validate")
return M