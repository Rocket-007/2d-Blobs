require "credits"
require "menu"
Avatar={}
function Avatar:init ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
choose=1
local m=15
local m2=11
avatar_1= {
rsx=210,
rsy=210,
image = love.graphics.newImage( 'imgs/blob1.png' ),
}
avatar_1.x,avatar_1.y= getGrid(W,H,6,m2)
avatar_1.sx=avatar_1.rsx/avatar_1.image:getWidth()
avatar_1.sy=avatar_1.rsy/avatar_1.image:getHeight()
avatar_1.rx=avatar_1.x-(avatar_1.rsx/2)
avatar_1.ry=avatar_1.y-(avatar_1.rsy/2)

avatar_2= {
rsx=200,
rsy=198,
image = love.graphics.newImage( 'imgs/blob2.png' ),
}
avatar_2.x,avatar_2.y= getGrid(W,H,m,m2)
avatar_2.sx=avatar_2.rsx/avatar_2.image:getWidth()
avatar_2.sy=avatar_2.rsy/avatar_2.image:getHeight()
avatar_2.rx=avatar_2.x-(avatar_2.rsx/2)
avatar_2.ry=avatar_2.y-(avatar_2.rsy/2)



avatar_3= {
rsx=156,
rsy=159,
image = love.graphics.newImage( 'imgs/blob3.png' ),
}
avatar_3.x,avatar_3.y= getGrid(W,H,24,m2)
avatar_3.sx=avatar_3.rsx/avatar_3.image:getWidth()
avatar_3.sy=avatar_3.rsy/avatar_3.image:getHeight()
avatar_3.rx=avatar_3.x-(avatar_3.rsx/2)
avatar_3.ry=avatar_3.y-(avatar_3.rsy/2)

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

function Avatar:draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (blobbg2,0,0,0,W/blobbg2:getWidth(),H/blobbg2:getHeight())
love.graphics.draw (blobbg1,-110,-20,0,(W/blobbg1:getWidth())+(110/blobbg1:getWidth() ) ,H/blobbg2:getHeight())

love .graphics .setColor (0 ,0, 0,0.9)
love.graphics.rectangle("fill",0,0,W,H)
love .graphics .setColor (1 ,1, 1)

love.graphics.draw (avatar_3.image ,avatar_3.rx,avatar_3.ry,0,avatar_3.sx,avatar_3.sy)
love.graphics.draw (avatar_2.image ,avatar_2.rx,avatar_2.ry,0,avatar_2.sx,avatar_2.sy)
love.graphics.draw (avatar_1.image ,avatar_1.rx,avatar_1.ry,0,avatar_1.sx,avatar_1.sy)
love.graphics.draw (btn15.image ,btn15.rx,btn15.ry,0,btn15.sx,btn15.sy)
love.graphics.print(tostring(choose),20,20)
end
return Avatar