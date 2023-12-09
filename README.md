# HC Util

A plugin for Neovim to provide utilities for my other plugins.

## Usage

```lua
local opts={
 hlgroup     ="RainbowCursor",
 autocmd     ={
  autostart=true,
  interval =72,
  group    ="RainbowCursor",
  event    ={"CursorMoved","CursorMovedI"},
 },
 timer       ={
  autostart=true,
  interval=14400,
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
local HCUtil=require("hcutil")
validate_val("opts",opts,"table")
HCUtil.validate_tab(opts,{
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
 },
})
```