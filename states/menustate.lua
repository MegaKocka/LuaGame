
MenuState = {}

-- Constructor
function MenuState:new()
  local State = {}
  setmetatable(State, { __index = MenuState })
  return State
end

function MenuState:init()
  buttons = {}
  
  mouseX = 0
  mouseY = 0
end

function MenuState:loadRes()
  -- Load images
  menubg = love.graphics.newImage("textures/menubg.png")
	play_button = love.graphics.newImage("textures/button_play.png")
	options_button = love.graphics.newImage("textures/button_options.png")
	cursor = love.graphics.newImage("textures/cursor.png")
  
  -- Load sounds
  sound = love.audio.newSource("sounds/click.wav", "static")
  
  buttons[0] = Button:new(200, 100, play_button, "play")
  buttons[1] = Button:new(200, 200, options_button, "options")
end

function MenuState:update(dt)
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()
end

function MenuState:draw()
  love.graphics.draw(menubg,0,0)

	for i = 0, 1 do
    buttons[i]:draw()
  end
	
	love.mouse.setVisible(false)
	love.graphics.draw(cursor, mouseX, mouseY)
end

function MenuState:keypress(key)
  
end

function MenuState:keyrelease(key)
  
end

function MenuState:mousepress(x, y, button)
  -- Update buttons
  local xPos = love.mouse.getX()
	local yPos = love.mouse.getY()
  
  for i = 0, 1 do
    buttons[i]:update(xPos, yPos)
  end
end

function MenuState:mouserelease(x, y, button)
  
end

function MenuState:buttonClick(text)
  -- Get button press
  if text == "play" then
    setState(GameState:new())
  end
end