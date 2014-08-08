--[[
  This is the abstract skeleton of a state. Add functions here first, before implementing it in an actual state.
]]--

State = {}

-- Constructor
function State:new()
  local object = {}
  setmetatable(object, { __index = State })
  return object
end

-- These get overriden in subclasses
function State:init()
    
end

function State:loadRes()
    
end

function State:update(dt)
    
end

function State:draw()
    
end

function State:keypress(key)
  
end

function State:keyrelease(key)
  
end

function State:mousepress(x, y, button)
  
end

function State:mouserelease(x, y, button)
  
end

function State:buttonClick(text)
  
end