-- Load Classes and external .lua files
require "entity/Player"
require "entity/SpriteAnimation"
require "camera"
---------------------------------------
function love.load()

	show_menu = true
	current_button_x = 0

  g = love.graphics
  width = g.getWidth()
  height = g.getHeight()

  g.setBackgroundColor(85, 85, 85)

  groundColor = {25, 200, 25}

  -- Load player animation
  animation = SpriteAnimation:new("entity/player.png", 32, 32, 4, 4)
  animation:load(delay)

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

function love.update(dt)
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

function love.draw()

if show_menu == false then

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

elseif show_menu == true then
	
	local xPos = love.mouse.getX()
	local yPos = love.mouse.getY()
	
	print("x : "..love.mouse.getX())
	print("y : "..love.mouse.getY())
	
	menubg = love.graphics.newImage("textures/menubg.png")
	play_button = love.graphics.newImage("textures/button_play.png")
	options_button = love.graphics.newImage("textures/button_options.png")
	cursor = love.graphics.newImage("textures/cursor.png")
	
	love.graphics.draw(menubg,0,0)
	
	current_button_x = 200
	
	
	
	love.graphics.draw(play_button,current_button_x,100)
	love.graphics.draw(options_button,current_button_x,200)
	
	
	love.mouse.setVisible(false)
	love.graphics.draw(cursor,xPos,yPos)
	
	
end

end

function love.keyreleased(key)
  -- Terminate game
  if key == "escape" then
    love.event.push("quit")
  end

  -- Stop player
  if (key == "right") or (key == "left") then
    p:stop()
  end
end

-- Camera function
function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end

function love.mousepressed( x, y, button)
	
	xPos = love.mouse.getX()
	yPos = love.mouse.getY()
	
	
	if show_menu == true then
	
		if xPos >= 190 and xPos <= 460 then
			if yPos >= 90 and yPos <= 150 then
				sound = love.audio.newSource("sounds/click.wav", "static")
				sound:play()
				show_menu = false
				print("GAME STARTED!")
			end
		end
	
	end

end


