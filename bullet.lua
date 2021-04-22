
Entity     = require 'entity'
class =require'middleclass.middleclass'


local Bullet = class('Bullet', Entity)

local width             = math.sqrt(2 * Grenade.radius * Grenade.radius)
local height            = width
local bounciness        = 0.4 -- How much energy is lost on each bounce. 1 is perfect bounce, 0 is no bounce
local lifeTime          = 4   -- Lifetime in seconds
local bounceSoundSpeed  = 30  -- How fast must a grenade go to make bouncing noises



function Grenade:initialize(world, parent, camera, x, y, vx, vy)
  Entity.initialize(self, world, x, y, width, height)
  self.parent = parent
  self.camera = camera
  self.vx, self.vy  = vx, vy
  self.lived = 0
  self.ignoresParent = true
end

function Grenade:filter(other)
  local kind = other.class.name
  --if kind == 'Block'
  **or kind == 'Player'
  --or(kind == 'Guardian' and not self.ignoresParent)
  --then
    return "bounce"
  --end
end

function Grenade:getBounceSpeed(nx, ny)
  if nx == 0 then return math.abs(self.vy) else return math.abs(self.vx) end
end

function Grenade:draw(drawDebug)

  local r,g,b = 255,0,0
  love.graphics.setColor(r,g,b)

  local cx, cy = self:getCenter()
  love.graphics.circle('line', cx, cy, Grenade.radius)

  local percent = self.lived / lifeTime

  g = math.floor(255 * percent)
  b = g

  love.graphics.setColor(r,g,b)

  love.graphics.circle('fill', cx, cy, Grenade.radius)

  if drawDebug then
    love.graphics.setColor(255,255,255,200)
    love.graphics.rectangle('line', self.l, self.t, self.w, self.h)
  end
end

function Grenade:destroy()
  Entity.destroy(self)
  Explosion:new(self.world, self.camera, self:getCenter())
end

return Grenade
