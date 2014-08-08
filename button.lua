
Button = {}

function Button:new(xp, yp, simage, stext)
  local object = {
    x = xp,
    y = yp,
    image = simage,
    width = simage:getWidth(),
    height = simage:getHeight(),
    text = stext
  }
  setmetatable(object, { __index = Button })
  return object
end

function Button:update(xPos, yPos)
  if xPos >= self.x and xPos <= (self.x + self.width) then
		if yPos >= self.y and yPos <= (self.y + self.height) then
			sound:play()
			currentState:buttonClick(self.text)
		end
	end
end

function Button:draw()
  love.graphics.draw(self.image, self.x, self.y)  
end