
local media    = require"media"
--local construct=require"construct"
--require"main"

function hehe1()
if ang_ljoy <= math.rad(29) and ang_ljoy >=  math.rad(-69)then
return "right" 

else return "left"
end
end

function hehe2()
if ang_ljoy >= math.rad(-120) and ang_ljoy <=  math.rad(-50)then
return "up" end

if ang_ljoy >= math.rad(50) and ang_ljoy <=math.rad(120) then
return "down" end
end
pausing=false
local gravityAccel  = 1000 -- pixels per second^2
local deadDuration  = 2 -- seconds until res-pawn
local runAccel      = 500 -- the player acceleration while going left/right
local brakeAccel    = 200--5000--2000
local jumpVelocity  = 600--800 -- the initial upwards velocity when jumping

local width         = 32
local height        = 64
local beltWidth     = 2
local beltHeight    = 8

local abs = math.abs

function drawblobStats(self)

local W, H = love.graphics.getWidth(),
love.graphics.getHeight()

--health
 love .graphics .setColor (0 , 0, 0)
  local a= love.graphics.getWidth()/9
   local b=14
  love.graphics.rectangle("fill",a*2,b,200,10)
 love .graphics .setColor (1 , 0, 0)
  love.graphics.rectangle("fill",a*2,b,self.health,10)
love .graphics .setColor (0 , 0, 0)
--love.graphics.setLineWidth(2)
love.graphics.rectangle("line",a*2,b,200,10)
  


--boost
 local c=30
 love .graphics .setColor (0 , 0, 0)
love.graphics.rectangle("fill",a*2,c,200,10)
 love .graphics .setColor (0, 0, 0.7)
  love.graphics.rectangle("fill",a*2,c,self.boost,10)
love .graphics .setColor (0 , 0, 0)
--love.graphics.setLineWidth(2)
love.graphics.rectangle("line",a*2,c,200,10)
  love .graphics .setColor (0 , 0, 0)

love.graphics.push()
love.graphics.scale(1.0)
love.graphics.printf( 
"FPS: "   ..love.timer.getFPS()..   "\n\nLIVES: "   ..blob.live..   "\nKILLCOUNT:  "   ..#Enemykill..   "\nROUND:  "   ..counter.stage..   "\nENEMIES LEFT: "   ..#enemies,
W/2+W/4,18,W,"left")
love.graphics.pop()
   love .graphics .setColor (1 , 1, 1)

if self.isDead then
Drawdeathscreen()
end

if self.live<=0 then
DrawRetryscreen()
end

if pausing then
Pausescreen()
end 

end



function blobload(map)
blob={
--x,y = 830 ,850 
w =80, 
h = 80, 
speed=500,
sprite =love.graphics. newImage("imgs/blob2.png"),
vx= 0,
vy = 0,
health = 200,
live=3,
boost = 200,
deadCounter = 0,
isBlob= true,
canShoot=true,
screem=false,
} 


local kn= map.objects
for i,v in pairs(kn) do
   if v.name=="spawnPlayer1" then
blob.spawn1x= v.x
blob.spawn1y= v.y
blob.x= v.x
blob.y= v.y
end
end
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()

failed = love.graphics.newImage( 'imgs/fail.png' )
respawning = love.graphics.newImage( 'imgs/respawn.png' )

btn19 = {
rsx=100,
rsy=50,
image = love.graphics.newImage( 'imgs/back.png' ),
}
btn19.x,btn19.y= getGrid(W,H,9,24)
btn19.sx=btn19.rsx/btn19.image:getWidth()
btn19.sy=btn19.rsy/btn19.image:getHeight()
btn19.rx=btn19.x-(btn19.rsx/2)
btn19.ry=btn19.y-(btn19.rsy/2)


btn20 = {
rsx=100,
rsy=50,
image = love.graphics.newImage( 'imgs/retry.png' ),
}
btn20.x,btn20.y= getGrid(W,H,21,24)
btn20.sx=btn20.rsx/btn20.image:getWidth()
btn20.sy=btn20.rsy/btn20.image:getHeight()
btn20.rx=btn20.x-(btn20.rsx/2)
btn20.ry=btn20.y-(btn20.rsy/2)

end

blobFilter = function(item, other)
if other.isEnemybullet then
return "cross"
end

if other.isBullet then
return "cross"
end

local kind
--if other. properties ~= nil then
--kind = other. properties
--else
kind = other.name
--end
if kind == "collidable"then
return 'slide'
end
if other.isBullet then
return "cross"
end
if other.isEnemy then
return "slide"
end
if other.isWall then
return "slide"
end
end 

function PlayerchangeVelocityByGravity(self,dt)
  self.vy = self.vy + gravityAccel * dt
end

function PlayerchangeByAngle(self,dt)
self.vx= self.vx*53*cos0*dt
self.vy= self.vy*53*sin0*dt
end

function PlayerchangeVelocityByCollisionNormal(self,nx, ny, bounciness)
  bounciness = bounciness or 0
  local vx, vy = self.vx, self.vy

  if (nx < 0 and vx > 0) or (nx > 0 and vx < 0) then
    vx = -vx * bounciness
  end

  if (ny < 0 and vy > 0) or (ny > 0 and vy < 0) then
    vy = -vy * bounciness
  end

  self.vx, self.vy = vx, vy
end


function updateBlob(self,dt)
    local bounciness =0.1 --0.4
         self.onGround = false
           local future_l = self.x + self.vx * dt
           local future_t = self.y + self.vy * dt

           local next_l, next_t, ccols, lennn = world:move(self, future_l , future_t , blobFilter)
        --end
  for i=1, lennn do
    local col = ccols[i]
    PlayerchangeVelocityByCollisionNormal(self,col.normal.x, col.normal.y, bounciness)
    PlayercheckIfOnGround(self,col.normal.y)
  end

 --layer.player.x=math.floor(blob.x+40)
--layer.player.y=math.floor(blob.y+31)
self.x,self.y=next_l, next_t

end


function PlayerchangeVelocityByKeys(self,dt)
  self.isJumpingOrFlying = false

  if self.isDead then return end

  local vx, vy = self.vx, self.vy

  if hehe1()=="left" then
    vx = vx - dt * (vx > 0 and brakeAccel or runAccel)
  elseif hehe1()=="right" then
    vx = vx + dt * (vx < 0 and brakeAccel or runAccel)
  else
    local brake = dt * (vx < 0 and brakeAccel or -brakeAccel)
    if math.abs(brake) > math.abs(vx) then
      vx = 0
    else
      vx = vx + brake
    end
  end

  if hehe2()=="up" and ( PlayercanFly(blob) or blob.onGround) then -- and (self:canFly() or self.onGround) then -- jump/fly
		  media.sfx.jet2:stop()
      media.sfx.jet2:play()
      vy = -jumpVelocity
    self.isJumpingOrFlying = true
     self.boost= self.boost-(dt*60)
  end

  self.vx, self.vy = vx, vy
end

function PlayerchangeVelocityByBeingOnGround(self)
  if self.onGround then
    self.vy = math.min(self.vy, 0)
  end
end

function PlayercheckIfOnGround(self,ny)
  if ny < 0 then self.onGround = true end
end


function Playerupdate(self,dt)
PlayerupdateHealth(blob,dt)
PlayerupdateBoost(blob,dt)
if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 and blob.live > 0 then
  PlayerchangeVelocityByKeys(blob,dt)
else
Friction(blob,dt)
end
--end
  PlayerchangeVelocityByGravity(blob,dt)

--if world:hasItem(self) then
  updateBlob(blob,dt)--self:moveColliding(blob,dt)
--end
--updateBlobsmoke(blob,dt)
  PlayerchangeVelocityByBeingOnGround(blob,dt)
  --PlayerchangeByAngle(blob,dt)
end


function PlayercanFly(self)
   if self.boost >= 0 then
  return true end
end

function PlayerupdateHealth(self,dt)
  self.achievedFullHealth = false
  if self.isDead then
       self.deadCounter = self.deadCounter + dt
    if self.deadCounter >= deadDuration then
      self.live= self.live-1
      Playerrespawn(self)
    end
  elseif self.health < 200 then
    self.health = math.min(200, self.health + (dt*6))
    self.achievedFullHealth = self.health == 200
  end
end

function PlayerupdateBoost(self,dt)
if self.onGround then 
   self.boost=math.min(200,self.boost+dt*70)
--else if hehe1()~=up then
   --self.boost=math.min(200,self.boost+dt*20)
--end

end
end

function Playerdie(self)
  self.canShoot=false
  self.isDead = true
  self.health = 0
  self.screem=true
end

function Playerrespawn(self)
local rspX,rspY=self.spawn1x,self.spawn1y--3000,150--250,150
self.isDead = false
self.canShoot=true

self.health = 200
self.boost = 200
self.deadCounter = 0
self.x,self.y=rspX,rspY
world: update (self,rspX,rspY)
end


function Friction(self,dt)
if self.onGround and (hehe1=="left" or hehe1=="right") then
media.sfx.step:stop()
media.sfx.step:play()
end
if self.onGround then
brakeAccel    = 2000
else
brakeAccel    = 1000
end

local vx, vy = self.vx, self.vy
local brake = dt * (vx < 0 and brakeAccel or -brakeAccel)
    if math.abs(brake) > math.abs(vx) then
      vx = 0
    else
      vx = vx + brake
    end
self.vx, self.vy = vx, vy
end

function Pausescreen()
love .graphics .setColor (0 , 0, 0,0.2)
  local a= love.graphics.getWidth()/6
   local b=14
  love.graphics.rectangle("fill",a,b, love.graphics.getWidth()-(a*2) ,300)
 --love .graphics .setColor (1 , 0, 0)
love.graphics.setLineWidth(5)
  love.graphics.rectangle("line",a,b, love.graphics.getWidth()-(a*2) ,300)
love .graphics .setColor (0 , 0, 0)
love.graphics.setLineWidth(1)
--love.graphics.draw (btn15.image ,btn15.x,btn15.y,0,btn15.sx,btn15.sy)
love .graphics .setColor (1, 1, 1)
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()

 
love.graphics.printf("PAUSED \n KILLCOUNT:  "..#Enemykill.."\n ROUND:  "..counter.stage.."",0,18,500,"center")


love.graphics.draw (btn19.image ,btn19.rx,btn19.ry,0,btn19.sx,btn19.sy)
--love.graphics.draw (btn20.image ,btn20.rx,btn20.ry,0,btn20.sx,btn20.sy)


end



function Drawdeathscreen()
love .graphics .setColor (0 , 0, 0,0.2)
  local a= love.graphics.getWidth()/6
   local b=14
  love.graphics.rectangle("fill",a,b, love.graphics.getWidth()-(a*2) ,300)
 --love .graphics .setColor (1 , 0, 0)
love.graphics.setLineWidth(5)
  love.graphics.rectangle("line",a,b, love.graphics.getWidth()-(a*2) ,300)
love .graphics .setColor (0 , 0, 0)
love.graphics.setLineWidth(1)
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
--love.graphics.draw (btn15.image ,btn15.x,btn15.y,0,btn15.sx,btn15.sy)
love .graphics .setColor (1 ,1, 1)

love.graphics.draw (respawning,
(love.graphics.getWidth()/2)-(100),
H/4,
0,
200/(respawning:getWidth()),
120/ respawning: getHeight()) 
 --love.graphics.draw (respawning,((love.graphics.getWidth()-1)/2)-(respawning:getWidth()/2),(H/4),0,2700/(respawning:getWidth()),1600/ respawning: getHeight()) 
 
love.graphics.printf(" \n KILLCOUNT:  "..#Enemykill.."\n RESPAWNING IN: "..math.floor(deadDuration-blob.deadCounter),0,18,500,"center")

end


function DrawRetryscreen()
love .graphics .setColor (0 , 0, 0,0.2)
  local a= love.graphics.getWidth()/6
   local b=14
  love.graphics.rectangle("fill",a,b, love.graphics.getWidth()-(a*2) ,300)
 --love .graphics .setColor (1 , 0, 0)
love.graphics.setLineWidth(5)
  love.graphics.rectangle("line",a,b, love.graphics.getWidth()-(a*2) ,300)
love .graphics .setColor (0 , 0, 0)
love.graphics.setLineWidth(1)
--love.graphics.draw (btn15.image ,btn15.x,btn15.y,0,btn15.sx,btn15.sy)
love .graphics .setColor (1, 1, 1)
local W, H = love.graphics.getWidth(),
love.graphics.getHeight()
love.graphics.draw (failed,a,H/5,0,(W-(a*2))/ failed:getWidth(),200/ failed: getHeight()) 
 
love.graphics.printf("YOU DIED \n KILLCOUNT:  "..#Enemykill.."\n ROUNDS SURVIVED:  "..counter.stage.."",0,18,500,"center")


love.graphics.draw (btn19.image ,btn19.rx,btn19.ry,0,btn19.sx,btn19.sy)
love.graphics.draw (btn20.image ,btn20.rx,btn20.ry,0,btn20.sx,btn20.sy)


end



function Updatedeathscreen(self)
if self.health <= 0 then
if self.deadCounter >= 0.7 then
self.screem=false
media.sfx.die9:stop()
end
if self.screem then
    --media.sfx.die9:stop()
    media.sfx.die9:play()
end

Playerdie(self)
end
end

function suvivalOver(self)
if self.live<=0 then
  self.canShoot=false
  --self.isDead = true
  self.health = 0
deadDuration  = 1000000
end
end


function retryam()
--[[
for i=1,#enemies do
--for i,v in pairs(enemies) do
   if world:hasItem(enemies[i]) then
	world:remove(enemies[i]) 
	table.remove(enemies,i) 
  	end
end
--]]
--Gamestate.switch(survival)

--[[
activeRadius  = 600--1000
lfireCoolDown  =0.9--.5--0.75 -- how much time the guardian takes to "regenerate a grenade"
aimDuration   = 0--1.25 -- time it takes to "aim"
targetCoolDown = 1--2 -- minimum time between "target acquired" chirps
enemybulletSpeed=1
--]]


for i=#enemies,1,-1 do
--for i,v in pairs(enemies) do
   if world:hasItem(enemies[i]) then
	world:remove(enemies[i]) 
	table.remove(enemies,i) 
  	end
end
counter={
deadCounter=1,
deadDuration=2,
stage=0,
}

end

return player