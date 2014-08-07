
Decoration = {}

function Decoration:new(xp, yp, simage)
  local object = {
    x = xp,
    y = yp,
    image = simage
  }
  setmetatable(object, { __index = Decoration })
  return object
end

function Decoration:update(dt)
   
end

function Decoration:draw()
  love.graphics.draw(self.image, self.x, self.y)  
end