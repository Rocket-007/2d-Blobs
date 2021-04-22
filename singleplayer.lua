require "construct"

singleplayer={}
function singleplayer:init ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
btn8 = {
rsx=230,
rsy=50,
image = love.graphics.newImage( 'imgs/storymode.png' ),
}
btn8.x,btn8.y= getGrid(W,H,15,8)
btn8.sx=btn8.rsx/btn8.image:getWidth()
btn8.sy=btn8.rsy/btn8.image:getHeight()
btn8.rx=btn8.x-(btn8.rsx/2)
btn8.ry=btn8.y-(btn8.rsy/2)

btn9 = {
rsx=230,
rsy=50,
image = love.graphics.newImage( 'imgs/survival.png' ),
}
btn9.x,btn9.y= getGrid(W,H,15,14)
btn9.sx=btn9.rsx/btn9.image:getWidth()
btn9.sy=btn9.rsy/btn9.image:getHeight()
btn9.rx=btn9.x-(btn9.rsx/2)
btn9.ry=btn9.y-(btn9.rsy/2)

btn10 = {
rsx=230,
rsy=50,
image = love.graphics.newImage( 'imgs/training.png' ),
}
btn10.x,btn10.y= getGrid(W,H,15,20)
btn10.sx=btn10.rsx/btn10.image:getWidth()
btn10.sy=btn10.rsy/btn10.image:getHeight()
btn10.rx=btn10.x-(btn10.rsx/2)
btn10.ry=btn10.y-(btn10.rsy/2)

btn15 = {
rsx=100,
rsy=50,
image = love.graphics.newImage( 'imgs/back.png' ),
}
btn15.x,btn15.y= getGrid(W,H,6,25)
btn15.sx=btn15.rsx/btn15.image:getWidth()
btn15.sy=btn15.rsy/btn15.image:getHeight()
btn15.rx=btn15.x-(btn15.rsx/2)
btn15.ry=btn15.y-(btn15.rsy/2)
end

function singleplayer:draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (blobbg2,0,0,0,W/blobbg2:getWidth(),H/blobbg2:getHeight())
love.graphics.draw (blobbg1,-110,-20,0,(W/blobbg1:getWidth())+(110/blobbg1:getWidth() ) ,H/blobbg2:getHeight())

love.graphics.draw (btn8.image ,btn8.rx,btn8.ry,0,btn8.sx,btn8.sy)
love.graphics.draw (btn9.image ,btn9.rx,btn9.ry,0,btn9.sx,btn9.sy)
love.graphics.draw (btn10.image ,btn10.rx,btn10.ry,0,btn10.sx,btn10.sy)
love.graphics.draw (btn15.image ,btn15.rx,btn15.ry,0,btn15.sx,btn15.sy)

love.graphics. print ("     SINGLEPLAYER" , 10, 10)
end

return singleplayer

