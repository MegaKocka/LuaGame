
MenuState = {}

-- Constructor
function MenuState:new()
  local State = {}
  setmetatable(State, { __index = MenuState })
  return State
end

-- These get overriden in subclasses
function MenuState:init()
  current_button_x = 0
end

function MenuState:loadRes()
  menubg = love.graphics.newImage("textures/menubg.png")
	play_button = love.graphics.newImage("textures/button_play.png")
	options_button = love.graphics.newImage("textures/button_options.png")
	cursor = love.graphics.newImage("textures/cursor.png")
  sound = love.audio.newSource("sounds/click.wav", "static")
end

function MenuState:update(dt)
  xPos = love.mouse.getX()
	yPos = love.mouse.getY()
end

function MenuState:draw()
  love.graphics.draw(menubg,0,0)
	
	current_button_x = 200

	love.graphics.draw(play_button,current_button_x,100)
	love.graphics.draw(options_button,current_button_x,200)
	
	love.mouse.setVisible(false)
	love.graphics.draw(cursor,xPos,yPos)
end

function MenuState:keypress(key)
  
end

function MenuState:keyrelease(key)
  
end

function MenuState:mousepress(x, y, button)
  
  xPos = love.mouse.getX()
	yPos = love.mouse.getY()
  
  if xPos >= 190 and xPos <= 460 then
			if yPos >= 90 and yPos <= 150 then
				sound:play()
				setState(GameState:new())
			end
		end
end

function MenuState:mouserelease(x, y, button)
  
end