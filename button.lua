
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
  if self:inBounds(xPos, yPos) then
		sound:play()
		currentState:buttonClick(self.text)
	end
end

function Button:draw()
  love.graphics.setColor(255, 255, 255)
  if self:inBounds(love.mouse.getX(), love.mouse.getY()) then
    love.graphics.setColor(100, 40, 70)
  end
  love.graphics.draw(self.image, self.x, self.y)  
  love.graphics.setColor(255, 255, 255)
end

function Button:inBounds(xPos, yPos)
  if xPos >= self.x and xPos <= (self.x + self.width) then
		if yPos >= self.y and yPos <= (self.y + self.height) then
			return true
		end
	end
  
  return false
end