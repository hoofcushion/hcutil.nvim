local M={}
---@param main string # Main table's name
---@param sub any # Index of Main table `main`
---@return string # Main table + Index
local function table_index_connect(main,sub)
 if type(sub)=="string" then
  if string.find(sub,"[A-Za-z][A-Za-z0-9]*") then
   return main.."."..sub
  else
   return main..'["'..sub..'"]'
  end
 end
 return main.."["..tostring(sub).."]"
end
local Validate={}
M.Validate=Validate
---@param value any
---@param target string|string[]
---@param name string
---@return boolean # Succeed
function Validate.type(value,target,name)
 return vim.validate({[name]={value,target}})
end
---@param value any
---@param target {[1]:(fun():boolean),[2]:string}
---@param name string
---@return boolean # Succeed
function Validate.fn(value,target,name)
 return vim.validate({[name]={value,target[1],target[2]}})
end
---@param main table
---@param tab table
---@param name string
---@return boolean # Succeed
function Validate.array(main,tab,name)
 for key,sub in ipairs(main) do
  local sub_name=table_index_connect(name,key)
  Validate.sub(sub,tab,sub_name)
 end
 return true
end
---@param main table
---@param tab table
---@param name string
---@return boolean # Succeed
function Validate.map(main,tab,name)
 for key,sub_tab in pairs(tab) do
  local sub_name=table_index_connect(name,key)
  local sub=main[key]
  Validate.sub(sub,sub_tab,sub_name)
 end
 return true
end
local function get_enums_string(enum_tab)
 local enums={}
 for enum in pairs(enum_tab) do
  table.insert(enums,enum)
 end
 return table.concat(enums,", ")
end
---@param main any
---@param tab table
---@param name string
---@return boolean # Succeed
function Validate.enum(main,tab,name)
 local s=pcall(Validate.type,main,tab[2],name)
 if s then
  return s
 end
 local valifn={
  [1]=function(x)
   return tab[1][x]~=nil
  end,
  [2]=get_enums_string(tab[1]),
 }
 Validate.fn(main,valifn,name)
 return true
end
local attribute={
 array=true,
 map=true,
 enum=true,
}
---@param main any
---@param tab table
---@param name string
---@return boolean # Succeed
function Validate.attribute(main,tab,name)
 local i=1
 while tab[i]~=nil do
  if tab[i]=="array" then
   Validate.array(main,tab[i+1],name)
  elseif tab[i]=="map" then
   Validate.map(main,tab[i+1],name)
  else -- if tab[i]=="enum" then
   Validate.enum(main,tab[i+1],name)
  end
  i=i+2
 end
 return true
end
---@param main any
---@param tab string|table
---@param name string
---@return boolean # Succeed
function Validate.sub(main,tab,name)
 Validate.type(tab,{"string","table"},name)
 if type(tab)=="string" then
  Validate.type(main,tab,name)
 else
  local target=tab[1]
  if attribute[target] then
   Validate.attribute(main,tab,name)
  elseif target==nil then
   Validate.map(main,tab,name)
  elseif type(target)=="function" then
   Validate.fn(main,tab,name)
  end
 end
 return true
end
---@param main table
---@param tab table
---@param name string|nil
---@return boolean # Succeed
function Validate.tab(main,tab,name)
 if name==nil then name="main_table" end
 Validate.map(main,tab,name)
 return true
end
return M
