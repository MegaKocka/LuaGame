
GameState = {}

-- Constructor
function GameState:new()
  local State = {}
  setmetatable(State, { __index = GameState })
  return State
end

-- These get overriden in subclasses
function GameState:init()
  g = love.graphics
  width = g.getWidth()
  height = g.getHeight()

  g.setBackgroundColor(85, 85, 85)

  groundColor = {25, 200, 25}

  -- Set default camera position
  camera:setBounds(0, 0, width, math.floor(height / 8))

  -- Instantiate a player
  p = Player:new()

  -- Set default values for the player
  p.x = 300
  p.y = 300
  p.width = 32
  p.height = 32
  p.jumpSpeed = -800
  p.runSpeed = 500

  -- Global values
  gravity = 1800
  delay = 120
  yFloor = 500
end

function GameState:loadRes()
  -- Load player animation
  animation = SpriteAnimation:new("entity/player.png", 32, 32, 4, 4)
  animation:load(delay)
end

function GameState:update(dt)
    -- Check keypresses
  if love.keyboard.isDown("right") then
    p:moveRight()
    animation:flip(false, false)
  end
  if love.keyboard.isDown("left") then
    p:moveLeft()
    animation:flip(true, false)
  end
  if love.keyboard.isDown("up") then
    p:jump()
  end

  -- Update player pos
  p:update(dt, gravity)

  -- Fix player bounds
  p.x = math.clamp(p.x, 0, width * 2 - p.width)
  if p.y < 0 then
    p.y = 0
  end
  if p.y > yFloor - p.height then
    p:hitFloor(yFloor)
  end

  -- update the sprite animation
  if (p.state == "stand") then
    animation:switch(1, 4, 200)
  end
  if (p.state == "moveRight") or (p.state == "moveLeft") then
    animation:switch(2, 4, 120)
  end
  if (p.state == "jump") or (p.state == "fall") then
    animation:reset()
    animation:switch(3, 1, 300)
  end
  animation:update(dt)

  -- Update camera position
  camera:setPosition(math.floor(p.x - width / 2), math.floor(p.y - height / 2))
end

function GameState:draw()
    camera:set()

  -- Round down x, y
  local x, y = math.floor(p.x), math.floor(p.y)

  -- Ground
  g.setColor(groundColor)
  g.rectangle("fill", 0, yFloor, width * 2, height)

  -- Player
  g.setColor(255, 255, 255)
  animation:draw(x, y)

 camera:unset()

  -- debug info
  g.print("Player coordinates: ("..x..","..y..")", 5, 5)
  g.print("Current state: "..p.state, 5, 20)
end

function GameState:keypress(key)
  
end

function GameState:keyrelease(key)
  if (key == "right") or (key == "left") then
    p:stop()
  end
end

function GameState:mousepress(x, y, button)
  
end

function GameState:mouserelease(x, y, button)
  
end

-- Camera function
function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end