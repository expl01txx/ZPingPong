const raylib = @cImport(@cInclude("raylib.h"));
const config = @import("config.zig");
const math = @import("math.zig");
const Ball = @import("ball.zig").Ball;

pub const Enemy = struct {
    box: math.Box,
    speed: i32 = config.ENEMY_SPEED,

    pub fn init(posX: i32, posY: i32) @This() {
        return .{ .box = .{ .position = @Vector(2, i32){ posX, posY }, .size = @Vector(2, i32){ config.PADDLE_WIDTH, config.PADDLE_HEIGTH } } };
    }

    pub fn update(self: *@This(), ball: *Ball) void {
        if (self.box.position[1] + @divFloor(self.box.size[1], 2) < ball.box.position[1]) {
            self.box.position[1] += self.speed;
        } else if (self.box.position[1] - @divFloor(self.box.size[1], 2) > ball.box.position[1]) {
            self.box.position[1] -= self.speed;
        }
    }
    pub fn draw(self: *@This()) void {
        raylib.DrawRectangle(self.box.position[0], self.box.position[1], self.box.size[0], self.box.size[1], raylib.RED);
    }
};
