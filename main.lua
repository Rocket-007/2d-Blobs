require "controls"
require "console"
require "guns"
require "blocks"
require "player"
require "enemy"
local Avatar=require"avatar"
local media  = require "media"
local menu= require "menu"
local singleplayer=require "singleplayer"
local construct=require"construct"
local credits=require"credits"
gamera=require "gamera.gamera"

local sti = require "sti.sti"
Gamestate = require "hump.gamestate"
--world = bump. newWorld(40)

local survival = {}
local pause = {}

function addButton(self)
--self.
end

function getGrid(x,y,p1,p2)
local sx,sy,xx,yy
sx=30
sy=sx

xx=x/sx
yy=y/sy
for i=1,sx do
for j=1,sy do
drawGrid(i*xx-(xx),j*yy -(yy) ,xx,yy )
end
end
pos1=p1*xx
pos2=p2*yy
return pos1,pos2
end

function drawGrid(x,y,w,h)
love.graphics.rectangle("line",x,y,w,h)
end


function clickButton(mx,my,button,btn)
if button == 1
and mx >= btn.rx and mx < btn.rx + btn.rsx
and my >= btn.ry and my < btn.ry + btn.rsy then
-- stuff to do when your image has been clicked
return true end
end

function menu:mousepressed(mx,my,button)
if clickButton(mx,my,button,btn1) then
media.sfx.grenade1:play()
Gamestate.switch(singleplayer)
end
if clickButton(mx,my,button,btn2) then
media.sfx.grenade1:play()
Gamestate.switch(construct)
end
if clickButton(mx,my,button,btn3) then
media.sfx.grenade1:play()
Gamestate.switch(Avatar)
end
if clickButton(mx,my,button,btn4) then
media.sfx.grenade1:play()
Gamestate.switch(construct)
end
if clickButton(mx,my,button,btn5) then
media.sfx.grenade1:play()
Gamestate.switch(construct)
end
if clickButton(mx,my,button,btn6) then
media.sfx.grenade1:play()
love .event .quit()
end

if clickButton(mx,my,button,btn7) then
media.sfx.grenade1:play()
Gamestate.switch(credits)
end

end

function credits:mousepressed(mx,my,button)
if clickButton(mx,my,button,btn15) then
media.sfx.grenade2:play()
Gamestate.switch(menu)
end
end




function pause:draw ()
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
-- draw previous screen
self.from:draw()
-- overlay with pause message
love.graphics.setColor( 0, 0, 0, 100)
love.graphics.rectangle( 'fill' , 0, 0, W,H)
love.graphics.setColor( 255, 255, 255)
love.graphics.printf( 'PAUSE' , 0, H / 2, W, 'center' )
love.graphics. print ("You Paused So Press Enter to continue" , 10, 10)
end

function pause :enter (from)
self.from = from -- record previous state
end


function singleplayer:mousepressed(mx,my,button)
if clickButton(mx,my,button,btn8) then
media.sfx.grenade1:play()
Gamestate.switch(construct)
end
if clickButton(mx,my,button,btn9) then
media.sfx.grenade1:play()
retry=true
Gamestate.switch(survival)
end
if clickButton(mx,my,button,btn10) then
media.sfx.grenade1:play()
Gamestate.switch(construct)
end
if clickButton(mx,my,button,btn15) then
media.sfx.grenade2:play()
Gamestate.switch(menu)
end
end

function construct:mousepressed(mx,my,button)
if clickButton(mx,my,button,btn15) then
media.sfx.grenade2:play()
Gamestate.switch(menu)
end
end

function survival:mousepressed(mx,my,button)

--[[
function love.mousepressed(x,y,button)
gooi.pressed() end
function love.mousereleased(x,y,button)
gooi.released() end
--]]

if clickButton(mx,my,button,btn19) and(blob.live <= 0 or pausing) then
retry=true
media.sfx.grenade2:play()
Gamestate.switch(menu)
pausing=false
else retry=false
end

if clickButton(mx,my,button,btn20) and blob.live <= 0 then
--Gamestate.switch(survival)
--love .event .quit("restart")
retry=true
--survival:enter()
media.sfx.grenade1:play()
Gamestate.switch(survival)

else retry=false
end

local a= love.graphics.getWidth()/9
   local b=14
 local c=30
if button == 1
and mx >=a*2 and mx <= 200 
and my >= 0 and my <( b+c) then
-- stuff to do when your image has been clicked
media.sfx.grenade1:play()
pausing=not pausing
end
--[[
if button == 1 and pausing ~= false
and mx >=a*2 and mx < 200
and my >= 14 and my < (10*2)+a+c then
-- stuff to do when your image has been clicked
pausing=false
end
--]]
end

function Avatar:mousepressed(mx,my,button)

if clickButton(mx,my,button,avatar_1) then
media.sfx.grenade1:play()
choose=1
love.graphics.print("1",10,10)
end
if clickButton(mx,my,button, avatar_2)then
media.sfx.grenade1:play()
choose=2
love.graphics.print("2",10,10)
end
if clickButton(mx,my,button, avatar_3)then
media.sfx.grenade1:play()
choose=3
love.graphics.print("3",10,10)
end

if clickButton(mx,my,button, btn15)then
media.sfx.grenade2:play()
Gamestate.switch(menu)
end
end



function survival:init()
--if retry then

--counter={}
--retryam()
--end

end

function survival:enter()
activeRadius  = 600--1000
fireCoolDown  =0.9--.5--0.75 -- how much time the guardian takes to "regenerate a grenade"
aimDuration   = 0--1.25 -- time it takes to "aim"
targetCoolDown = 1--2 -- minimum time between "target acquired" chirps
enemybulletSpeed=1
--gooi:load() 
--love .graphics .setBackgroundColor ( 0.21 , 0.67 , 0.97 )
gunload()

cos0 = 0
sin0 = 0
bg =love.graphics. newImage("imgs/mapbg.png") 

cam = gamera.new(-1900 ,-1600,7130,7460)
sxx = 0.38--0.22
cam:setScale(sxx)-- 
	
	
	-- Load map file
	map = sti("Map02.lua",{"bump"})
 map:resize(love.graphics.getWidth()*3.2,love.graphics.getHeight()*3.2)
	 	map:bump_init(world)


	--map = sti('assets/levels/level_1.lua',{"bump"})
--map:resize(love.graphics.getWidth()*4.7,love.graphics.getHeight()*4.7)
	 blobload(map)
--map:resize(love.graphics.getWidth()*3.7,love.graphics.getHeight()*3.7)
	 map:resize(love.graphics.getWidth()*2.7,love.graphics.getHeight()*2.7)
	 	map:bump_init(world)


world:add (blob, blob.x, blob.y, blob.w, blob.h) 

layer =map:addCustomLayer( "Sprites" , 3)
local player
for k, object in pairs(map.objects) do
    if object.name =="Player" then
        player = object
        ak47= object
        break
    end
end

--layer.player.oy
-- Create player object
--blob.sprite =love.graphics.newImage( "imgs/blob1.png" )
layer.player = {
sprite = blob.sprite,
x      = blob.x ,
y      = blob.y,
sx=190/blob.sprite:getWidth(),
sy=195/blob.sprite:getHeight(),
r=0,
ox     =300,
oy     =380
}
layer.ak47 = {
sprite = gun.sprite,
x      = ak47.x ,
y      = ak47.y,
sx=200/gun.sprite:getWidth(),
sy=100/gun.sprite:getHeight(),
r=0,
ox     =(gun.sprite:getWidth()/2)-30,
oy     =(gun.sprite:getHeight()/2)-30
}
-- Draw player
layer.draw = function(self)
love.graphics.draw(self.player.sprite,
math.floor(self.player.x),
math.floor(self.player.y),
--math.floor(blob.x),
--math.floor(blob.y),
layer.player.r,layer.player.sy,flip,
--0, layer.player.sx , layer.player.sy,
self.player.ox,
self.player.oy)

love.graphics.draw(self.ak47.sprite,
math.floor(self.ak47.x),
math.floor(self.ak47.y),
layer.ak47.r ,layer.ak47.sx,flip2,
self.ak47.ox,
self.ak47.oy)

flip=-layer.player.sx
flip2=-layer.ak47.sy

-- Temporarily drawa point at our location so we know
-- that our sprite is offset properly
love.graphics.setPointSize( 5 )
love.graphics.points( math.floor(self.player.x),
math .floor(self.player.y))
love .graphics .setColor (1 , 1, 0)
love.graphics.setPointSize( 5 )
love.graphics.points( math.floor(self.ak47.x),
math .floor(self.ak47.y))
end

layer.update = function(self, dt)
if choose ==1 then
self.player.sprite =love.graphics. newImage("imgs/blob1.png") 
choose=nil
elseif choose==2 then
self.player.sprite =love.graphics. newImage("imgs/blob2.png") 
choose=nil
else if choose ==3 then
self.player.sprite =love.graphics. newImage("imgs/blob3.png") 
choose=nil
end end

end
-- Remove unneeded object layer
--map:removeLayer("collision")
spawnEnemy(map)
--if Gamestate.current() ==survival then
--media.music.survival:play()
--media.music.menu:stop()
--end
--loadBlobsmoke ()
--blob.sprite =love.graphics. newImage("imgs/blob1.png") 


end





function survival:update(dt)

gooi.update(dt)
	map:update(dt)
yyy=dt


ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 
cos0 = math.cos(ang_ljoy)
sin0 = math.sin(ang_ljoy)
--updateBlob(dt)
gunupdate()
layer.player.x=(blob.x+40)
layer.player.y=(blob.y+31)


if blob.canShoot and blob.live > 0 then
ang_rjoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 
end
gunlen = math.sqrt(rjoy:xValue()*rjoy:xValue()+rjoy:yValue()*rjoy:yValue() )
cos = math.cos(ang_rjoy)
sin = math.sin(ang_rjoy)

if not (ang_rjoy >= math.rad(-90) and ang_rjoy <= math.rad(90)) then
flip=-layer.player.sx
flip2=-layer.ak47.sy
else 
flip=layer.player.sx
flip2=layer.ak47.sy
end

if ang_rjoy >= math.rad(30) and ang_rjoy <=  math.rad(90)then
layer.player.r = math.rad(30)
elseif ang_rjoy >= math.rad(90) and ang_rjoy <=math.rad(150) then
layer.player.r = math.rad(150)
elseif ang_rjoy <= math.rad(-30) and ang_rjoy >=  math.rad(-90)then
layer.player.r = math.rad(-30)
elseif ang_rjoy <= math.rad(-90) and ang_rjoy >= math.rad(-150) then
layer.player.r = math.rad(-150)

else layer.player.r=ang_rjoy
end
bulletUpdate(dt)
local screeen_width =love.graphics.getWidth()/ sxx
local screeen_height =love.graphics.getHeight()/ sxx
tx = math .floor(blob.x - screeen_width /2 )
ty = math .floor(blob.y -screeen_height /2 )
local player =map.layers[ "Sprites" ].player

--PlayerchangeVelocityByKeys(blob,dt)
Playerupdate(blob,dt)
cam:setPosition(blob.x,blob.y)



for _,o in ipairs(enemies) do
Guardianupdate(o,dt)
end
updateEnemyBulletcols(dt)
Updatedeathscreen(blob)
spawnEnemyUpdate(dt)
--UpdateEnemySpawnCounter(counter)

if retry then
activeRadius  = 600--1000
lfireCoolDown  =0.9--.5--0.75 -- how much time the guardian takes to "regenerate a grenade"
aimDuration   = 0--1.25 -- time it takes to "aim"
targetCoolDown = 1--2 -- minimum time between "target acquired" chirps
enemybulletSpeed=1
counter={}
retryam()
end

--retry=false
end


--function survival:mousepressed()
--Gamestate.push(pause)
--end


function survival: draw()
--drawBlobSmoke()
local scale = 1
screen_width =love.graphics.getWidth()
screen_height =love.graphics.getHeight()
love .graphics .setColor (1 , 1, 1)
love.graphics.draw(bg,0,0,0,screen_width/bg:getWidth(),
screen_height/bg:getHeight()) 
local player =map.layers[ "Sprites" ].player
	
	love .graphics .setColor (1 , 1, 1)
	bb, cc=cam:getPosition()
	 map:draw(-tx,-ty,sxx,sxx)--tx,-ty),2,2
	
love .graphics .setColor (0 , 0, 0)
cam:draw(function()

drawBlob()
--love .graphics .setColor (1 , 0, 0)
--love .graphics .setColor (0 , 0, 0)
drawBlocks() 
drawBullets() 
drawenemyBullets()
drawEnemies()
bulletDraw()

end)
gooi.draw() 
drawblobStats(blob)

console.draw()
end

function survival:touchpressed (id, x,y)
gooi.pressed(id, x, y) end

function survival:touchreleased(id, x, y)
gooi.released(id, x, y) end

function survival:touchmoved (id, x, y) 
gooi.moved(id, x, y) end


function love . load()
gooi:load() 
media.load()
love . window. setMode ( 0, 0 ,
{fullscreen = true}
)
 --media.sfx.jet2:stop()
local W, H = love.graphics.getWidth(), love.graphics.getHeight()
--getGrid(W,H,1,2)

Gamestate.registerEvents()
Gamestate.switch(menu)
end


function love.update(dt)
if Gamestate.current() == menu then
media.music.survival:stop()
media.music.menu:play()

elseif Gamestate.current() == survival then
media.music.menu:stop()
media.music.survival:play()
end

if Gamestate.current() ~= survival then
--media.sfx.menu:play()
retry=false
end
media.cleanup()
end


--endy

--if Gamestate.current() ==survival then
--[[
function love.touchpressed (id, x,y)
gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y)
gooi.released(id, x, y) end

function love.touchmoved (id, x, y) 
gooi.moved(id, x, y)
--end
end --]]