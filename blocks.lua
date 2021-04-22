bump = require 'bump.bump'

world = bump. newWorld(40)

--require "guns"
local opacity= 0.3
local opacity2= 1
local bulletscol={}
-- helper function
 function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,opacity)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b,opacity2)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end

 function drawBox2(box, r,g,b)
  love.graphics.setColor(r,g,b,0)
  love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
  love.graphics.setColor(r,g,b,0)
  love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end
--function love.load() end
--function love.update() end
--function love.draw() end

function drawBlob()
  drawBox2(blob, 255, 255, 255)
end

-- Block functions
 blocks = {}
local bullets = {}
--billet= bullets

function addBlock(x,y,w,h)
    local block = {x=x,y=y,w=w,h=h,isWall= true}
    blocks[#blocks+1] = block
    world:add(block, x,y,w,h)
end




function drawBlocks()
    for _,block in ipairs(blocks) do
        drawBox(block, 0,0,0)
    end
end
addBlock(3707,       412,     500, 32)
addBlock(3707,       912,     150, 32)

addBlock(3707,       1792,     500, 32)
addBlock(4200,      412,      32, 1410)
  --addBlock(800-32, 32,      32, 600-32*7)
  --addBlock(0,      600-32, 2700, 32)

return Blocks