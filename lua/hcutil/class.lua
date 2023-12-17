local M={}
---@class meta_class
local Class={}
M.Class=Class
---Create basic class with inherit
---@generic self
---@param self self
---@return self
function Class:__new()
 return setmetatable({},{__index=self})
end
return M
