require "lib.class"

Ball = class()

--[[
    This version uses radius to build a circle
]]
-- function Ball:init(x, y, radius)
--     self.x = x
--     self.y = y
--     self.radius = radius

--     self.dx = 0
--     self.dy = 0
-- end
--[[
    This version uses width and height to build a rectangle
]]
function Ball:init(x, y, width, height)
    self.initial_x = x
    self.initial_y = y

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = 0
    self.dy = 0

    self.color = {
        r = math.random(),
        g = math.random(),
        b = math.random(),
        a = 1
    }
end

function Ball:reset()
    self.x = self.initial_x
    self.y = self.initial_y

    self.dx = 0
    self.dy = 0
end

function Ball:hasCollidedWith(object)
    if self.x + self.width < object.x or self.x > object.x + object.width then
        return false;
    end
    if self.y + self.height < object.y or self.y > object.y + object.height then
        return false
    end
    return true
end

function Ball:checkCollisionsAndDeflect(objects)
    for i = 1, #objects do
        if self:hasCollidedWith(objects[i]) then
            if self.x < objects[i].x then
                self.dx = -self.dx
            else
                self.dx = -self.dx
            end
            if self.y < objects[i].y then
                self.dy = -self.dy
            else
                self.dy = -self.dy
            end
        end
    end
end

function Ball:update(dt, screen_width, screen_height)
    if self.x + self.width >= screen_width or self.x <= 0 then
        self.dx = -self.dx
    end

    if self.y + self.height >= screen_height or self.y <= 0 then
        self.dy = -self.dy
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw()
    color_r, color_g, color_b, color_a = love.graphics.getColor()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(color_r, color_g, color_b, color_a)
end
