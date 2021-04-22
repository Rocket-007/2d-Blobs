function love . conf(t )
--t .window .borderless = true -- Remove all border visuals from the window (boolean)
--t .window .resizable = true
t . window.fullscreen= true
--t.window.usedpiscale= false
--t.window.width = 800
  --t.window.height = 640

 -- t .window .fullscreentype = "desktop"

end
--[[
[code]
local gamera=require "gamera.gamera"
local bump = require 'bump.bump'
local sti = require "sti.sti"
function love.load()
blob={
x = 430 , 
y =250 , 
w =30, 
h = 60, 
speed=200
} 
cam = gamera.new(-1900 ,-1600,7130,7460)

sxx = 0.7

cam:setScale(sxx)
	
	
	-- Load map file
	map = sti("Map01.lua",{"bump"})
map:resize(love.graphics.getWidth(),love.graphics.getHeight())
	
world = bump. newWorld(40)
	map:bump_init(world)
end

function love.update(dt)
	map:update(dt)
end

function love . draw()
tx = math .floor(blob.x - screeen_width /2 )
ty = math .floor(blob.y -screeen_height /2 )
love .graphics .setColor (1 , 1, 1)
map:draw(-tx,-ty,sxx,sxx)
love .graphics .setColor (0 , 0, 0)
map:bump_draw(world,-tx,-ty,sxx,sxx)

	cam:draw(function()

drawBlob()
end
end) 
[/code]
--]] 

