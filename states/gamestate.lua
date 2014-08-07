
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
  p:init()

  -- List of decoration items
  decors = {}

  -- Global values
  gravity = 1800
  delay = 120
  yFloor = 400
end

function GameState:loadRes()
  gamebg = love.graphics.newImage("textures/gamebg.png")
  treeImg = love.graphics.newImage("textures/tree.png")
  decors[0] = Decoration:new(100, 220, treeImg)
  decors[1] = Decoration:new(280, 220, treeImg)
  decors[2] = Decoration:new(650, 220, treeImg)
end

function GameState:update(dt)
    -- Check keypresses
  if love.keyboard.isDown("right") then
    p:moveRight()
  end
  if love.keyboard.isDown("left") then
    p:moveLeft()
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

  -- Update camera position
  camera:setPosition(math.floor(p.x - width / 2), math.floor(p.y - height / 2))
end

function GameState:draw()
  -- Background
  love.graphics.draw(gamebg, 0, 0)
  
  camera:set()

  -- Draw decors
  for i = 0, 2 do
    decors[i]:draw()
  end

  -- Ground
  g.setColor(groundColor)
  g.rectangle("fill", 0, yFloor, width * 2, height)

  -- Player
  g.setColor(255, 255, 255)
  p:draw()
  
 camera:unset()

  -- debug info
  g.print("Player coordinates: ("..math.floor(p.x)..","..math.floor(p.y)..")", 5, 5)
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