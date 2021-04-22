
require "blocks"
enemies={}
test={}
require "guns"
require "player"
local media  = require "media"



Enemykill={}
local gravityAccel  = 1000 -- pixels per second^2
local Phi           = 0.61803398875
local height        = 110
local width         = height * (1 - Phi)
--[[
local activeRadius  = 600--1000
local fireCoolDown  =0.9--.5--0.75 -- how much time the guardian takes to "regenerate a grenade"
local aimDuration   = 0--1.25 -- time it takes to "aim"
local targetCoolDown = 1--2 -- minimum time between "target acquired" chirps
enemybulletSpeed=1
--]]
local EnemyBulletSpeed =700--1000

local spawnEnemy1, spawnEnemy2, spawnEnemy3, spawnEnemy4
counter={
deadCounter=1,
deadDuration=2,
stage=0,
}
function targetgetCenter(self)
  return self.x + self.w / 2,
         self.y + self.h / 2
end


function drawEnemies(dt)
    for _,o in ipairs(enemies) do
        
         love .graphics .setColor (1 , 1, 1)
        love.graphics.rectangle("fill",(o.x-200/2)+(o.w/2),o.y-40,200,30)
        drawBox(o, 0,1,1)
        love.graphics.rectangle("fill",(o.x-200/2)+(o.w/2),o.y-40,o.health,30)
        love.graphics.print(o.health,o.x,o.y-120,0,4)


  local cx,cy = GuardiangetCenter(o)
  love.graphics.setColor(255,0,0)
  local radius = 40--Grenade.radius
  if o.isLoading then
    local percent = o.fireTimer / fireCoolDown
    local alpha = math.floor(1 * percent)
    radius = radius * percent

    love.graphics.setColor(0,100,200,alpha)
    love.graphics.circle('fill', cx, cy, radius)
    love.graphics.setColor(0,100,200)
    love.graphics.circle('line', cx, cy, radius)
  else
    if o.aimTimer > 0 then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,100,200)
    end
    love.graphics.circle('line', cx, cy, radius)
    love.graphics.circle('fill', cx, cy, radius)

    if drawDebug then
      love.graphics.setColor(255,255,255,100)
      love.graphics.circle('line', cx, cy, activeRadius)
    end

    if o.isNearTarget then
      local tx,ty = targetgetCenter(blob)

      if drawDebug() then
        love.graphics.setColor(255,255,255,100)
        love.graphics.line(cx, cy, tx, ty)
      end

      if o.aimTimer > 0 then
        love.graphics.setColor  (1,0.4,0.4,1) --(255,100,100,200)
      else
        love.graphics.setColor (1,0,0,0.8) --(0,0.4,0.7,1)   --(0,100,200,100)
      end
      love.graphics.setLineWidth(2)
      --if o.laserX~= nil and o.laserY ~= ni then
         love.graphics.line(cx, cy, o.laserX, o.laserY)
       --end
      love.graphics.setLineWidth(1)
    end

  end

        
    end

end

function Guardianupdate(self,dt)
  self.isNearTarget         = false
  self.isLoading            = false
  self.laserX, self.laserY  = nil,nil

  self.timeSinceLastTargetAquired = self.timeSinceLastTargetAquired + dt

  if self.fireTimer < fireCoolDown then
    self.fireTimer = self.fireTimer + dt
    self.isLoading = true
  else
    local cx,cy = GuardiangetCenter(self)
    local tx,ty = targetgetCenter(blob)

    local dx,dy = cx-tx, cy-ty
    local distance2 = dx*dx + dy*dy

    if distance2 <= activeRadius * activeRadius then
      self.isNearTarget = true
      local itemInfo, len = world:querySegmentWithCoords(cx,cy,tx,ty)
      for i=1,len do
      -- ignore itemsInfo[1] because that's always self
      local info = itemInfo[i]
      if info then
        self.laserX = info.x1
        self.laserY = info.y1
        if info.item ==blob then-- self.target then
          if self.aimTimer == 0 and self.timeSinceLastTargetAquired >= targetCoolDown then
            --media.sfx.guardian_target_acquired:play()
            self.timeSinceLastTargetAquired = 0
          end
          self.aimTimer = self.aimTimer + dt
          if self.aimTimer >= aimDuration then
            enemyfire(self,self.x, self.y,dt)
            table.insert(test,3)
            self.fireTimer = 0
            self.aimTimer = 0
          end
        else
          self.aimTimer = 0
        end
      end
      end
    else
      self.aimTimer = 0
    end
  end
local future_l = self.x + self.vx * dt
local future_t = self.y + self.vy * dt
local next_l, next_t, cols, len = world:move(self, future_l, future_t, enemyFilter)
PlayerchangeVelocityByGravity(self,dt)
self.x,self.y=next_l, next_t
end

function PlayerchangeVelocityByGravity(self,dt)
  self.vy = self.vy + gravityAccel * dt
end


  
function addEnemy(px, py)
	local o = {
		x = px, -- position X
		y = py, -- posi3ion Y
     vx= 0,
     vy = 0,
		r = 20, -- radius
     h =140,
     w =80,
		health =  200, -- health
		moveSpeed =  200, -- movement speed
		knockSpeed = 0, -- knock speed
		knockDir = 0, -- knock direction
		knockCos = 0, -- knock X multiplier
		knockSin = 0, -- knock Y multiplier
		knockFrict = 500, -- knock friction
     target = blob,
     camera = camera,
     fireTimer = 0,
     aimTimer  = 0,
     timeSinceLastTargetAquired = targetCoolDown,
     isEnemy=true
	}
	table.insert(enemies, o)
   world:add(o,o.x,o.y,o.w,o.h)
	return o
end


function GuardiangetCenter(self)
  return self.x + width / 2,
         self.y + height * (1 - Phi)
end

function EntitygetCenter(self)
  return self.l + self.w / 2,
         self.t + self.h / 2
end


function drawDebug()
return true
end


function enemyfire(self,x,y,dt)
  local cx, cy = GuardiangetCenter(self)
  local tx, ty = blob.x,blob.y
  local vx, vy = (tx - cx) * enemybulletSpeed, (ty - cy) * enemybulletSpeed
  local angle = math.atan2(ty-cy,tx-cx)
  addenemyBulletcol( cx , cy ,vx,vy, angle,EnemyBulletSpeed) --400)
media.sfx.zap:stop()
media.sfx.zap:play()
  self.fireTimer = 0
  self.aimTimer = 0
end

function updateEnemyBulletcols(dt)
for i,o in ipairs (enemybulletcols) do
local bounciness=0.3
local future_l = o.x + o.vx * dt
local future_t = o.y + o.vy * dt
local next_l, next_t, cols, len = world:move(o, future_l, future_t, enemybulletFilter)

  for z=1, len do
    local col = cols[z]
    if col.other.isBlob then
     media.sfx.slash:stop()
     media.sfx.slash:play()
     col.other.health=col.other.health-o.damage
        if world:hasItem(enemybulletcols[i]) then
           world:remove(enemybulletcols[i]) 
           table.remove(enemybulletcols,i )
        	end
      end
							if col.other.isWall then
         		       if world:hasItem(enemybulletcols[i]) then
             	        world:remove(enemybulletcols[i])             	  
               	 table.remove(enemybulletcols, i)
           		     end
            end
    --if col.other.properties.collidable== "true" then
     if col.other.name == "collidable" then
        if world:hasItem(enemybulletcols[i]) then
           world:remove(enemybulletcols[i]) 
           table.remove(enemybulletcols,i )
       	end
     end
      local nx, ny = col.normal.x, col.normal.y
  end
o.x, o.y = next_l, next_t
if calc(o.xX,o.x,o.yY,o.y) >= 1000  then
    	   if world:hasItem( enemybulletcols[i]) then
    
            world:remove( enemybulletcols[i])	 
     	    table.remove( enemybulletcols , i)
		     	--table.remove(bullets, i)
      end

    end   
end
end

enemybulletFilter = function(item, other)
if other.isEnemybullet then
return "cross"
end
if other.isBullet then
return "cross"
end
if other.isEnemy then
return "cross"
else
return "cross" 
end
end 



enemyFilter= function(item, other)
if other.isBlob then
return "slide"
end
if other.isEnemybullet then
return "cross"
end
if other.isEnemy then
return "cross"
else
return "slide" 
end
end 

spawnEnemyLoc ={}
function spawnEnemy(map)
local kn= map.objects
for i,v in pairs(kn) do
   if v.name=="spawnEnemy1" then
       spawnEnemyLoc[1]=v
   end

   if v.name=="spawnEnemy2" then
       spawnEnemyLoc[2]=v
   end

   if v.name=="spawnEnemy3" then
       spawnEnemyLoc[3]=v
   end

   if v.name=="spawnEnemy4" then
       spawnEnemyLoc[4]=v
   end
end
end

function EnemySpawnCounter(self,dt)
--  self.achievedFullHealth = false
  if self.isStart then
       self.deadCounter = self.deadCounter + dt
    if self.deadCounter >= self.deadDuration then
      Enemyrespawn (self)
    end
  end
end




EnemyLoc={
a=100,
b=200,
c=300,
d=400,
e=-100,
f=-200,
}
mathh={}
function mathh.randomchoice(t)
local keys={}
for key,value in pairs(t) do
keys[#keys+1]=key
end
index=keys[math.random(1,#keys)]
return t[index]
end


function Enemyrespawn(self)
if self.isStart then
media.sfx.checkpoint:play()
self.stage=self.stage+1
end
activeRadius  = activeRadius+70--1000
fireCoolDown  =math.max(0.2,fireCoolDown*0.9)--0.75 -- how much time the guardian takes to "regenerate a grenade"
targetCoolDown = 1--2 -- minimum time between "target acquired" chirps
enemybulletSpeed = math.min(7,enemybulletSpeed *1.1)--+(self.stage*3)--700--1000

if self.stage <= 5 then
for i=self.stage*3,1,-1 do
local rad=math.random(4)
addEnemy(spawnEnemyLoc[rad].x+math.random( mathh.randomchoice(EnemyLoc)),spawnEnemyLoc[rad].y)
end
elseif self.stage >= 6 then
for i=12,1,-1 do
local rad=math.random(4)
addEnemy(spawnEnemyLoc[rad].x+math.random( mathh.randomchoice(EnemyLoc)),spawnEnemyLoc[rad].y)
end
end

self.isStart = false
self.deadCounter = 1
end

function UpdateEnemySpawnCounter(self)
if #enemies <= 0 then
self.isStart = true
end
end


function spawnEnemyUpdate(dt)
EnemySpawnCounter(counter,dt)
UpdateEnemySpawnCounter(counter)
end


return enemy