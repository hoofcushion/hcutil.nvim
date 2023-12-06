local M={}
local function validate_val(name,value,type,errormsg)
 vim.validate({[name]={value,type,errormsg}})
end
M.validate_val=validate_val
---@class sentry
---@field [1] string
---@class fentry
---@field [1] fun():boolean
---@field [2] nil|string
---@alias valitab table<string,type|fentry|sentry|valitab>
---@param inp table
---@param valitab valitab
local function validate_tab(inp,valitab)
 validate_val("inp",    inp,    "table")
 validate_val("valitab",valitab,"table")
 for k,entry in pairs(valitab) do
  validate_val("key",  k,    "string")
  validate_val("entry",entry,{"string","table"})
  if type(entry)=="string" then
   validate_val(k,inp[k],entry)
  else
   if entry[1] then
    validate_val(k,inp[k],entry[1],entry[2])
   else
    validate_tab(inp[k],entry)
   end
  end
 end
end
M.validate_tab=validate_tab
return M
