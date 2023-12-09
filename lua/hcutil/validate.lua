local M={}
local function validate_val(name,value,type,errormsg)
 vim.validate({[name]={value,type,errormsg}})
end
M.validate_val=validate_val
local function validate_tab(inp,valitab)
 validate_val("input table",inp,"table")
 validate_val("validate tab",valitab,"table")
 for k,entry in pairs(valitab) do
  validate_val("validate tab key: "..k,k,"string")
  validate_val("validate tab entry of key: "..k,entry,{"string","table"})
  if type(entry)=="string" then
   validate_val("input table entry of key: "..k,inp[k],entry)
  else
   if entry[1] then
    validate_val("input table entry[1] of key: "..k,entry[1],{"function","table","string"})
    if type(entry[1])=="function" then
     validate_val(k,inp[k],entry[1],entry[2])
    else
     validate_val(k,inp[k],entry)
    end
   else
    validate_tab(inp[k],entry)
   end
  end
 end
end
M.validate_tab=validate_tab
return M