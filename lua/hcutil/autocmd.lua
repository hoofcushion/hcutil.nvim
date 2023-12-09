local M={}
local function load_autocmds(autocmds)
 local init,func,fini=autocmds.init,autocmds.func,autocmds.fini
 if init then init() end
 if func==nil then return end
 vim.api.nvim_create_augroup(func[2].group,{})
 vim.api.nvim_create_autocmd(func[1],func[2])
 if fini==nil then return end
 local event,opts=fini[1],fini[2]
 opts.once=true
 local function clear_autocmd()
  vim.api.nvim_clear_autocmds({
   pattern=opts.pattern,
   buffer=opts.buffer,
   group=opts.group,
  })
 end
 local new_callback=clear_autocmd
 local old_callback=opts.callback
 if old_callback then
  new_callback=function()
   old_callback()
   clear_autocmd()
  end
 end
 opts.callback=new_callback
 vim.api.nvim_create_autocmd(event,opts)
end
local function prase_autocmds(group,autocmds)
 if autocmds.init==true then
  autocmds.init=function()
   print("Autocmds "..group.." created")
  end
 end
 if autocmds.func then
  autocmds.func[2].group=group
 end
 if autocmds.fini then
  local opts=autocmds.fini[2]
  opts.group=group
  if opts.callback==true then
   opts.callback=function()
    print("Autocmds "..group.." cleared")
   end
  end
 end
 return autocmds
end
function M.load_grouped_autocmds(group,autocmds)
 autocmds=prase_autocmds(group,autocmds)
 load_autocmds(autocmds)
end
function M.create_autocmd_object(group,autocmds)
 autocmds=prase_autocmds(group,autocmds)
 local Obj={}
 Obj.active=false
 function Obj:start()
  if self.active==true then return end
  load_autocmds(autocmds)
  self.active=true
 end
 function Obj:delete()
  if self.active==false then return end
  vim.api.nvim_clear_autocmds({group=group})
  vim.api.vim_del_augroup_by_name(group)
  self.active=false
 end
 return Obj
end
return M