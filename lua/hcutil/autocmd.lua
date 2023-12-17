local M={}
-- Get augroup map by name
function M.nvim_get_augroups_by_name()
 local augroups={}
 local output=vim.api.nvim_exec("augroup",true)
 for group in output:gmatch("[^ ]+") do
  augroups[group]=true
 end
 return augroups
end
local function fn_combine(main,sub)
 local new_fn=function(...)
  sub()
  return main(...)
 end
 return new_fn
end
---@class nvim_create_autocmd_param
---@field [1] nvim_autocmd_event
---@field [2] nvim_create_autocmd_opts
---@class autocmds
---@field init function|nil
---@field func nvim_create_autocmd_param
---@field fini nvim_create_autocmd_param|nil
---@class Autocmd_Object: meta_class
---@field start fun(self):self
---@field delete fun(self):self
---@field group string
---@field autocmds autocmds
---@field active boolean
local Autocmd=require("class"):__new()
---@class Autocmd_Object_Private: Autocmd_Object
---@field Create_Autocmd fun(self)
---@field Parse_Autocmd fun(self)
local Autocmd_private=Autocmd:__new()
M.Autocmd=Autocmd
function Autocmd_private:Create_Autocmd()
 vim.api.nvim_create_augroup(self.group,{})
 local autocmds=self.autocmds
 local init,func,fini=autocmds.init,autocmds.func,autocmds.fini
 if init~=nil then
  init()
 end
 if func[2].once==true then
  func[2].callback=fn_combine(func[2].callback,function() self:delete() end)
 end
 vim.api.nvim_create_autocmd(func[1],func[2])
 if fini~=nil then
  fini[2].callback=fn_combine(fini[2].callback,function() self:delete() end)
  vim.api.nvim_create_autocmd(fini[1],fini[2])
 end
end
function Autocmd_private:Parse_Autocmd()
 local autocmds=self.autocmds
 local func=autocmds.func
 if func[2].group==nil then
  func[2].group=self.group
 end
 local fini=autocmds.fini
 if fini~=nil then
  if fini[2].group==nil then
   fini[2].group=self.group
  end
 end
end
function Autocmd:start()
 if self.active~=true then
  Autocmd_private.Create_Autocmd(self)
  self.active=true
 end
 return self
end
function Autocmd:delete()
 if self.active~=false then
  vim.api.nvim_clear_autocmds({group=self.group})
  vim.api.nvim_del_augroup_by_name(self.group)
  self.active=false
 end
 return self
end
---@param group string
---@param autocmds autocmds
---@return Autocmd_Object
function Autocmd:create(group,autocmds)
 local New=setmetatable({},{__index=self})
 New.autocmds=autocmds
 Autocmd_private.Parse_Autocmd(New)
 New.group=group
 New.active=false
 return New
end
return M
