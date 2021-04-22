require "blocks"
local media  = require "media"
--require "enemy"
bulletSpeed = 1050
bullets = {}
ak47= {}
--local player
	player = {
		--x = width / 2, y = height / 2, r = 20,
		angle = 0,
		speedX = 0, speedY = 0,
		speedAcc = 2500, speedFrc = 750, speedMax = 300,
		cooldown = 0, cooldownAdd = 0.15,--0.40,
		health = 100, healthMax = 100, healthRegen = 30, hit = false
	}


function addBullet(x,y,w,h)
    local bullet = {x=x,y=y,w=w,h=h,isBullet=true}
    bullets[#bullets+1] = bullet
    world:add(bullet, x,y,w,h)
end

function drawBullets()
    for _,bullet in ipairs(bullets) do
        drawBox2(bullet, 0,0,0)
    end
end

function drawenemyBullets()
    for _,o in ipairs(enemybulletcols) do
        drawBox(o, 0,0,0)
    end
end


enemybulletcols = { }
function addenemyBulletcol(px, py,vxx,vyy,d, s)
	local o = {
		x = px, -- position X
		y = py, -- position Y
     xX = px, -- position X
		yY = py, -- position Y
		r =  8, -- radius
     w =  40, -- radius
     h =  40, -- radius
		moveSpeed = s, -- movement speed
		moveDir = d, -- movement direction
		moveX =math.cos(d) * s,
		moveY =math.sin(d) * s,
    --vx =math.cos(d) * s,
    --vy =math.sin(d) * s,
    vx =vxx,
    vy =vyy,
     damage=30,
     isEnemybullet=true
    	}
	 table.insert( enemybulletcols , o)
   world:add(o,o.x,o.y,o.w,o.h)
	return o
end
  
--addenemyBulletcol( layer.player. x , layer.player. y , 1, 30)

-- bullet functions & variables:
bulletcols = { }
function addBulletcol(px, py, d, s)
	local o = {
		x = px, -- position X
		y = py, -- position Y
     xX = px, -- position X
		yY = py, -- position Y
		r =  8, -- radius
     w =  20, -- radius
     h =  20, -- radius
		moveSpeed = s, -- movement speed
		moveDir = d, -- movement direction
		moveX =math.cos(d) * s,
		moveY =math.sin(d) * s,
    damage= 20,
     isBullet=true
    	}
	table.insert(bulletcols, o)
  addBullet(startXX,startYY,20,20)

	return o
end
  
function wee(a,b)
local jjx= (a+ 30)- a
local jjy=(b+30)- b
local lenh=math.sqrt(jjx*jjx+jjy*jjy)
return lenh*math.cos(ang_rjoy ),lenh*math.sin(ang_rjoy)
end


function gunload()

bullet = love.graphics.newImage("imgs/bullet.png")

gun = {
sprite =love.graphics. newImage("imgs/ak47.png")

}

end

function gunupdate()
layer.ak47.x=blob.x+blob.h/2
layer.ak47.y= (blob.y+blob.w/2)+30
--layer.ak47.x= layer.player.x--+20
--layer.ak47.y= layer.player.y+50
layer.ak47.r=ang_rjoy
end

--function bullets.filter()
bulletFilter = function(item, other)
if other.isWall then
return "slide" 
end
if other.isBlob then
return "cross"
end
if other.isBullet then
return "cross"
end
if other.isEnemy then
return "cross"
--elseif
--return "cross"

else 
return "cross"
end
end

function calc(a1,b1,a2,b2)
local c1=b1-a1
local c2=b2-a2
local len = math.sqrt(c1*c1+c2*c2)
return len
end

function bulletUpdate(dt)

-- shoot:
	player.cooldown = math.max(0, player.cooldown - dt)

if not (lock.checked) == true and player.cooldown <= 0 and blob.canShoot and gunlen >=0.94 and blob.live > 0 then
--player.cooldown = player.cooldownAdd
--addBulletcol(startX,startY,ang_rjoy , 500)
media.sfx.ak47:stop()
media.sfx.ak47:play()

local angle = ang_rjoy
startX = layer.ak47. x+90
startY = layer.ak47. y+(layer.ak47.sy-30)
--startXX,startYY=wee(startX,startY)
hh=calc(startX,startX+80,startY,startY+80)
startXX= layer.player. x +math.cos(ang_rjoy )*110
startYY= layer.player. y +math.sin(ang_rjoy )*110
player.cooldown = player.cooldownAdd
addBulletcol(startXX,startYY,angle,1800) 

end

for i,o in ipairs(bulletcols) do
   		o.x = o.x + o.moveX * dt
		  o.y = o.y + o.moveY * dt
      bullets[i].x,bullets[i].y, cols, len = world:move(bullets[i], o.x , o.y , bulletFilter)
         for z=1,len do
            coll=cols[z]
            for j,t in ipairs (enemies) do
           		 		if coll.other.isEnemy then
                     media.sfx.clank1:stop()
                     media.sfx.clank1:play()
              	 		 coll.other.health= coll.other.health-o.damage
         		      	 if world:hasItem(bullets[i]) then
                     
             	        		world:remove(bullets[i]) 
               		 table.remove(bulletcols, i)
		      	   	  	 table.remove(bullets, i)

           		     		end
  								 end

                 if t.health <=0 then
														if world:hasItem(enemies[j]) then
                                     table.insert(Enemykill,0)
		      	   	   								world:remove(enemies[j]) 
																	table.remove(enemies,j) 
  													end
           	
										end
          	  end

							if coll.other.isWall then
         		       if world:hasItem(bullets[i]) then
             	        world:remove(bullets[i])             	  
               	 table.remove(bulletcols, i)
		      	   	   table.remove(bullets, i)
           		     end
            end
    					--if col.other.properties.collidable== "true" then
     					if coll.other.name == "collidable" then
       						 if world:hasItem(bullets[i]) then
          						 world:remove(bullets[i]) 
               	 		 table.remove(bulletcols, i)
          						 table.remove(bullets,i )
       						 end
    					 end
 									
         end

		if calc(o.xX,o.x,o.yY,o.y) >= 1000  then
    	   if world:hasItem(bullets[i]) then
            world:remove(bullets[i])	 
     	    table.remove(bulletcols, i)
		     	table.remove(bullets, i)
      end

    end
end


end

--[[
world:remove(blocks[1])
world:remove(blocks[3])
world:remove(blocks[2])
world:remove(blocks[4])
for i=1,4 do
blocks[i] = nil
end
--]]
function bulletDraw()

 love .graphics .setColor (1 ,1 , 1)
--for i ,v in ipairs (bullets ) do
--love. graphics. draw(bullet , v .x , v .y ,v.a, 2.3,1.4,bullet:getWidth()-10)
--end
--for i=1,len do
--end
local i,l
i = 1
	l = #bulletcols
	love.graphics.setColor(1,4,0,1)
	while i <= l do
		o = bulletcols[i]
		love.graphics.circle("fill", o.x, o.y , 6, 13)
		love.graphics.circle("line", o.x , o.y , 9, 13)
		i = i + 1
	end
end
return gun