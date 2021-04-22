construct={}
function construct:init ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
constructing=love.graphics.newImage( 'imgs/construct.png' )


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

function construct:draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (constructing ,0,0,0,W/ constructing :getWidth(),H/ constructing: getHeight()) 

love.graphics.draw (btn15.image ,btn15.rx,btn15.ry,0,btn15.sx,btn15.sy)

--love.graphics. print ("     CONSTRUCT" , 10, 10)

love.graphics.push()
  love .graphics .setColor (1 , 0.3, 0)
love.graphics.scale(1.2)
love.graphics. printf("    STILL UNDER CONSTRUCTION!" ,-140, 10,W,"right")
love.graphics.pop()
  love .graphics .setColor (1 , 1, 1)

end


return construct