# HC Util

A plugin for Neovim to provide utilities for my other plugins.

## Usage

```lua
local HCUtil=require("hcutil")
local M={}
local default_opts={
 hlgroup     ="RainbowCursor",
 autocmd     ={
  autostart=true,
  interval =90,
  group    ="RainbowCursor",
  event    ={"CursorMoved","CursorMovedI"},
 },
 timer       ={
  autostart=true,
  interval=18000,
 },
 color_amount=360,
 hue_start   =0,
 saturation  =100,
 lightness   =50,
 others      ={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
M.options=vim.deepcopy(default_opts)
local function number(x)
 return type(x)=="number"
end
local function integer(x)
 return number(x) and x%1==0
end
local function is_string(x)
 return type(x)=="string"
end
local valitab={
 hlgroup     ="string",
 autocmd     ={
  autostart="boolean",
  interval ={function(x) return integer(x) and x>0 or is_string(x) end,"integer x, x>0; or string"},
  group    ="string",
  event    ={"string","table"},
 },
 timer       ={
  autostart="boolean",
  interval={function(x) return integer(x) and x>0 or is_string(x) end,"integer x, x>0; or string"},
 },
 color_amount={function(x) return integer(x) and x>0 end,"integer x, x>0"},
 hue_start   ={function(x) return number(x) and x>=0 and x<=360 end,"integer x, 0<=x<=360"},
 saturation  ={function(x) return number(x) and x>=0 and x<=100 end,"integer x, 0<=x<=100"},
 lightness   ={function(x) return number(x) and x>=0 and x<=100 end,"integer x, 0<=x<=100"},
 others      ={
  create_cmd="boolean",
  create_var="boolean",
  create_api="boolean",
  reuse_opts="boolean",
 },
}
---@param user_options table
function M.setup(user_options)
 if type(user_options)~="table" then
  return
 end
 local opts=vim.tbl_deep_extend("force",default_opts,user_options)
 HCUtil.validate_tab(opts,valitab)
 if opts.others.reuse_opts==true then
  opts=vim.tbl_deep_extend("force",M.options,user_options)
 end
 M.options=opts
end
return M
```

