--require "enemy"
console={}

see={}
--countme=world:countItems()
function console.draw()

--[[

love .graphics .setColor (1 , 1, 1)

    love.graphics. print (tostring(love.timer.getFPS(), 10, 10))
love.graphics. print (tostring(tx), 10, 20)
love.graphics. print (tostring(ty), 10, 30)
love.graphics. print (tostring(-tx), 10, 50)
    love.graphics. print (tostring(-ty), 10, 60)
love.graphics. print (tostring(bb-screen_width), 10, 70)
love.graphics. print (tostring(cc-screen_height), 10, 80)
love.graphics. print (tostring(#blocks), 10, 90)
  love.graphics. print (tostring(layer.ak47.sx), 10, 100)
  love.graphics. print (tostring(math.deg(ang_rjoy)), 10, 110)
  love.graphics. print (tostring(#bullets), 10, 120)
  --love.graphics. print (tostring(#billet), 10, 130)
  love.graphics. print (tostring(#bulletcols), 10, 150)

love.graphics. print ("startXX:"..tostring(startXX), 10, 170)
love.graphics. print ("startYY:"..tostring(startYY), 10, 180)
love.graphics. print ("startX:"..tostring(startX), 10, 200)
love.graphics. print ("startY:"..tostring(startY), 10, 210)
if see.other ~= nil then
love.graphics. print ("hh:otherded with"..tostring(see.other.isWall), 10, 230)
end
--if other.isWall then
function hehe()
if ang_ljoy >= math.rad(-120) and ang_ljoy <=  math.rad(-50)then
--layer.player.r = math.rad(30)
return "up"

elseif ang_ljoy >= math.rad(50) and ang_ljoy <=math.rad(120) then
--layer.player.r = math.rad(150)
return "down"
elseif ang_ljoy <= math.rad(49) and ang_ljoy >=  math.rad(-49)then
--layer.player.r = math.rad(-30)
return "right"
--elseif ang_ljoy <= math.rad(-90) and ang_ljoy >= math.rad(-150) then
--layer.player.r = math.rad(-150)
else return "left"
end
end
love.graphics. print ("key input:  "..tostring( hehe()), 10, 240)
love.graphics. print ("enemies remaining  "..tostring( #enemies ), 10, 250)
if #test ~= nil then
love.graphics. print ("milk me i shoot "..tostring( #test ), 10, 260)
end

love.graphics. print ("EnemyBullet "..tostring(#enemybulletcols ), 10, 270)
love.graphics. print ("EnemyBullet "..tostring(blob.health), 10, 280)

aaabb=10
for i,v in pairs(blob) do
love.graphics. print (tostring(i)..":"..tostring(v),300,aaabb)
aaabb=aaabb+10
end

aaaabb=10
for i,v in pairs(counter) do
love.graphics. print (tostring(i)..":"..tostring(v),150,aaaabb)
aaaabb=aaaabb+10
end


--local kn= map.objects--["spawnEnemy2"]--["Layer 3"]["data"]
--for i,v in pairs(kn) do
--love.graphics. print (tostring(i)..":"..tostring(v.name),150,aaaabb)
--aaaabb=aaaabb+10
--end


love.graphics. print ("em"..":"..tostring( #Enemykill ),10,290)

love.graphics. print ("em"..":"..tostring(retry),10,300)
love.graphics. print ("bulletspeed"..":"..tostring(enemybulletSpeed),10,310)

love.graphics. print ("bulletspeed"..":"..tostring(pausing ),20,20)
--]]

end
return console