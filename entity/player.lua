
Player = {}

-- Constructor
function Player:new()
  local object = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    xSpeed = 0,
    ySpeed = 0,
    state = "",
    jumpSpeed = 0,
    runSpeed = 0,
    canJump = false,
    animation = nil
  }
  setmetatable(object, { __index = Player })
  return object
end

function Player:init()
  self.x = 300
  self.y = 300
  self.width = 32
  self.height = 32
  self.jumpSpeed = -800
  self.runSpeed = 500
  
  self.animation = SpriteAnimation:new("entity/player.png", 32, 32, 4, 4)
  self.animation:load(delay)
end

-- Movement functions
function Player:jump()
  if self.canJump then
    self.ySpeed = self.jumpSpeed
    self.canJump = false
  end
end
 
function Player:moveRight()
  self.xSpeed = self.runSpeed
  self.state = "moveRight"
  self.animation:flip(false, false)
end
 
function Player:moveLeft()
  self.xSpeed = -1 * (self.runSpeed)
  self.state = "moveLeft"
  self.animation:flip(true, false)
end
 
function Player:stop()
  self.xSpeed = 0
end
 
function Player:hitFloor(maxY)
  self.y = maxY - self.height
  self.ySpeed = 0
  self.canJump = true
end

-- Update function
function Player:update(dt, gravity)
  -- update player pos
  self.x = self.x + (self.xSpeed * dt)
  self.y = self.y + (self.ySpeed * dt)
 
  -- apply gravity
  self.ySpeed = self.ySpeed + (gravity * dt)
 
  -- update player state
  if not(self.canJump) then
    if self.ySpeed < 0 then
      self.state = "jump"
    elseif self.ySpeed > 0 then
      self.state = "fall"
    end
  else
    if self.xSpeed > 0 then
      self.state = "moveRight"
    elseif self.xSpeed < 0 then
      self.state = "moveLeft"
    else
      self.state = "stand"
    end
  end
  
  -- update the sprite animation
  if (self.state == "stand") then
    self.animation:switch(1, 4, 200)
  end
  if (self.state == "moveRight") or (self.state == "moveLeft") then
    self.animation:switch(2, 4, 120)
  end
  if (self.state == "jump") or (self.state == "fall") then
    self.animation:reset()
    self.animation:switch(3, 1, 300)
  end
  self.animation:update(dt)
end

function Player:draw()
  local x, y = math.floor(self.x), math.floor(self.y)
  self.animation:draw(x, y)
end