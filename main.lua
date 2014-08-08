-- Load Classes and external .lua files
require "camera"
require "button"
require "entity/Player"
require "entity/SpriteAnimation"
require "entity/decoration"
require "states/state"
require "states/menustate"
require "states/gamestate"
---------------------------------------
function love.load()
  setState(MenuState:new())
end

function love.update(dt)
  currentState:update(dt)
end

function love.draw()
  currentState:draw()
end

function love.keyreleased(key)
  -- Terminate game
  if key == "escape" then
    love.event.push("quit")
  end

  currentState:keyrelease(key)
end

function love.mousepressed(x, y, button)
  currentState:mousepress(x, y, button)
end

function setState(state)
  currentState = state
  state:init()
  state:loadRes()
end