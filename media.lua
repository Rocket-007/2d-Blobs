local multisource = require 'multisource.multisource'
local media = {}

local function newSource(name)
  local path = 'sfx/' .. name .. '.wav'
  local source = love.audio.newSource(path,"static")
  
  return multisource.new(source) or multisource.new(source2)
end

local function newSource2(name)
  local path = 'sfx/' .. name .. '.ogg'
  local source = love.audio.newSource(path,"static")

  return multisource.new(source)
end

--[[
local function newSource3(name)
  local path = 'sfx/' .. name .. '.mp3'
  local source = love.audio.newSource(path,"static")
  return multisource.new(source)
end
--]]

media.load = function()
  local names = [[
    ak47
    zap
    die9
    jet
    checkpoint
    clank1
    ricochet
    slash 
    step
	  grenade1
    grenade2
  ]]
  local names2 = [[
    jet2
  ]]


--[[
  local names3 = [[

  ]]
    --menu
    --survival
--]]

  media.sfx = {}
  media.music = {}
  for name in names:gmatch('%S+') do
    media.sfx[name] = newSource(name)
  end

  for name in names2:gmatch('%S+') do
    media.sfx[name] = newSource2(name)
  end

--[[
  for name in names3:gmatch('%S+') do
    media.sfx[name] = newSource3(name)
  end
--]]
  --media.sfx.player_propulsion:setLooping(true)
  --media.music = love.audio.newSource('sfx/wrath_of_the_djinn.xm', 'stream')
  --media.music:setLooping(true)
  media.music.menu = love.audio.newSource('sfx/menu.mp3', 'stream')
  media.music.menu:setLooping(true)
  media.music.survival = love.audio.newSource('sfx/survival.mp3', 'stream')
  media.music.survival:setLooping(true)

end

media.cleanup = function()
  for _,sfx in pairs(media.sfx) do
    sfx:cleanup()
  end
end

media.countInstances = function()
  local count = 0
  for _,sfx in pairs(media.sfx) do
    count = count + sfx:countInstances()
  end
  return count
end


return media
