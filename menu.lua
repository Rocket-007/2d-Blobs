
local media=require "media"
local menu = {}

function menu :init ()

local left=4
local right=26
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
blobbg2=love.graphics.newImage( 'imgs/blob-bg2.png' )
blobbg1=love.graphics.newImage( 'imgs/blob-bg.png' )
title=love.graphics.newImage( 'imgs/title.png' )

btn1 = {
rsx=190,
rsy=50,
image = love.graphics.newImage( 'imgs/singleplayer.png' ),
}
btn1.x,btn1.y= getGrid(W,H,9,26)
btn1.sx=btn1.rsx/btn1.image:getWidth()
btn1.sy=btn1.rsy/btn1.image:getHeight()
btn1.rx=btn1.x-(btn1.rsx/2)
btn1.ry=btn1.y-(btn1.rsy/2)

btn2 = {
rsx=190,
rsy=50,
image = love.graphics.newImage( 'imgs/multiplayer.png' ),
}
btn2.x,btn2.y= getGrid(W,H,21,26)
btn2.sx=btn2.rsx/btn2.image:getWidth()
btn2.sy=btn2.rsy/btn2.image:getHeight()
btn2.rx=btn2.x-(btn2.rsx/2)
btn2.ry=btn2.y-(btn2.rsy/2)

btn3= {
rsx=60,
rsy=55,
image = love.graphics.newImage( 'imgs/avatar.png' ),
}
btn3.x,btn3.y= getGrid(W,H,left,8)
btn3.sx=btn3.rsx/btn3.image:getWidth()
btn3.sy=btn3.rsy/btn3.image:getHeight()
btn3.rx=btn3.x-(btn3.rsx/2)
btn3.ry=btn3.y-(btn3.rsy/2)

--[[
btn= {
rsx=80,
rsy=27,
image = love.graphics.newImage( 'imgs/love.png' ),
}
btn.x,btn.y= getGrid(W,H,5,10)
btn.sx=btn.rsx/btn.image:getWidth()
btn.sy=btn.rsy/btn.image:getHeight()
btn.rx=btn.x-(btn.rsx/2)
btn.ry=btn.y-(btn.rsy/2)
end --]]

btn4= {
rsx=60,
rsy=55,
image = love.graphics.newImage( 'imgs/settings.png' ),
}
btn4.x,btn4.y= getGrid(W,H,left,14)
btn4.sx=btn4.rsx/btn4.image:getWidth()
btn4.sy=btn4.rsy/btn4.image:getHeight()
btn4.rx=btn4.x-(btn4.rsx/2)
btn4.ry=btn4.y-(btn4.rsy/2)

btn5= {
rsx=60,
rsy=55,
image = love.graphics.newImage( 'imgs/shop.png' ),
}
btn5.x,btn5.y= getGrid(W,H,left,20)
btn5.sx=btn5.rsx/btn5.image:getWidth()
btn5.sy=btn5.rsy/btn5.image:getHeight()
btn5.rx=btn5.x-(btn5.rsx/2)
btn5.ry=btn5.y-(btn5.rsy/2)

btn6= {
rsx=55,
rsy=55,
image = love.graphics.newImage( 'imgs/exit.png' ),
}
btn6.x,btn6.y= getGrid(W,H,right,8)
btn6.sx=btn6.rsx/btn6.image:getWidth()
btn6.sy=btn6.rsy/btn6.image:getHeight()
btn6.rx=btn6.x-(btn6.rsx/2)
btn6.ry=btn6.y-(btn6.rsy/2)

btn7= {
rsx=55,
rsy=55,
image = love.graphics.newImage( 'imgs/about.png' ),
}
btn7.x,btn7.y= getGrid(W,H,right,18)
btn7.sx=btn7.rsx/btn7.image:getWidth()
btn7.sy=btn7.rsy/btn7.image:getHeight()
btn7.rx=btn7.x-(btn7.rsx/2)
btn7.ry=btn7.y-(btn7.rsy/2)
end

--function menu:update()
--if Gamestate.current() ==menu then
--hend
--end

function menu :draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (blobbg2,0,0,0,W/blobbg2:getWidth(),H/blobbg2:getHeight())
love.graphics.draw (blobbg1,-110,-20,0,(W/blobbg1:getWidth())+(110/blobbg1:getWidth() ) ,H/blobbg2:getHeight())
love.graphics.draw (title ,0,0,0,W/title:getWidth(),H/title:getHeight()) 

love.graphics.draw (btn1.image ,btn1.rx,btn1.ry,0,btn1.sx,btn1.sy)
love.graphics.draw (btn2.image ,btn2.rx,btn2.ry,0,btn2.sx,btn2.sy)

love.graphics.draw (btn3.image ,btn3.rx,btn3.ry,0,btn3.sx,btn3.sy)
love.graphics.draw (btn4.image ,btn4.rx,btn4.ry,0,btn4.sx,btn4.sy)
love.graphics.draw (btn5.image ,btn5.rx,btn5.ry,0,btn5.sx,btn5.sy)
love.graphics.draw (btn6.image ,btn6.rx,btn6.ry,0,btn6.sx,btn6.sy)
love.graphics.draw (btn7.image ,btn7.rx,btn7.ry,0,btn7.sx,btn7.sy)

love.graphics. print ("     MENU" , 10, 10)
end

return menu
