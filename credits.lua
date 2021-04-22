credits={}
function credits :init ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
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

function credits:draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (btn15.image ,btn15.rx,btn15.ry,0,btn15.sx,btn15.sy)

love.graphics. print ("     CREDITS" , 10, 10)
  love .graphics .setColor (0.6, 0.8, 0)

love.graphics.printf(" NGWU CHARLES OBINNA(ROCKET):\nGame Systems Programming \nLevel Design and Scripting \nSound Design and Music \nUI Programming \nProduction \n\nNGWU FELIX IKENNA(RAMPAGE): \nGraphics Artist \nCharacter Design \nUI Design \n\nNGWU DENNIS EMEKA(ROOKIE): \nOfficial Test Runner \n\nSpecial Thanks To Those That Contributed In Any Way To the \nMaking Of 2d Blobs. ",
0,10,W,"center")
  love .graphics .setColor (1 ,1, 1)

end



return credits