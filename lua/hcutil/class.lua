local M={}
---@class meta_class
---@field __new fun(base:table):table
local Class={}
M.Class=Class
---Create basic class with inherit
---@generic self:table
---@param base self
---@return self
function Class.__new(base)
 return setmetatable({},{__index=base})
end
return M
