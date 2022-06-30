require "lib.class"

Wall = class()

function Wall:init(x, y, width, height)
    self.initial_x = x
    self.initial_y = y

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.color = {
        r = 1,
        g = 0,
        b = 0,
        a = 1
    }
end

function Wall:reset()
    self.x = self.initial_x
    self.y = self.initial_y
end

function Wall:hasCollidedWith(object)
    if self.x + self.width < object.x or self.x > object.x + object.width then
        return false;
    end
    if self.y + self.height < object.y or self.y > object.y + object.height then
        return false
    end
    return true
end

function Wall:update(dt, screen_width, screen_height)

end

function Wall:draw()
    color_r, color_g, color_b, color_a = love.graphics.getColor()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(color_r, color_g, color_b, color_a)
end
