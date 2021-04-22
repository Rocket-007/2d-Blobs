require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.spinner"
require "gooi.component"
require "gooi.checkbox"

local W, H = love.graphics.getWidth(),
love.graphics.getHeight()

function gooi:load()
lock=gooi.newCheck({
text = "Lock" ,
x = 14 ,
y = 48 ,
w = 200 ,
h = 40,--75,
--group = "grp1" ,
checked = true -- default = false
}):change()

ljoy = gooi.newJoy({x=66, 
y=198, 
size = 90,})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
--:noSpring() 
--:setDigital()
--:direction)

rjoy = gooi.newJoy({x=W-160,--x=332, 
y=194, 
size = 90})

--:setImage( "/imgs/joys.png" )


:noScaling()

:anyPoint()

:noSpring() 

--:setDigital()

--:direction()
end

return gooi

