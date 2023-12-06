# HC Util

A plugin for Neovim to provide utilities for my other plugins.

## Usage

```lua
local opts={
 hlgroup="Cursor",
 autostart=true,
 interval=3600,
 color_amount=360,
 hue_start=0,
 saturation=100,
 lightness=50,
 others={
  create_cmd=true,
  create_var=true,
  create_api=true,
 },
}
local Util=require("hcutil")
validate_val("opts",opts,"table")
Util.validate_tab(opts,{
 hlgroup     ="string",
 autostart   ="boolean",
 interval    ={function(x) return integer(x) or type(x)=="string" end,"integer or string"},
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