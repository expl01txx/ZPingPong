const raylib = @cImport(@cInclude("raylib.h"));
const config = @import("config.zig");
const math = @import("math.zig");

pub const Player = struct {
    box: math.Box,
    speed: i32 = config.PLAYER_SPEED,

    pub fn init(posX: i32, posY: i32) @This() {
        return .{ .box = .{ .position = @Vector(2, i32){ posX, posY }, .size = @Vector(2, i32){ config.PADDLE_WIDTH, config.PADDLE_HEIGTH } } };
    }

    pub fn update(self: *@This()) void {
        if (raylib.IsKeyDown(raylib.KEY_W) and self.box.position[1] > config.WINDOW_OFFSET) {
            self.box.position[1] -= self.speed;
        } else if (raylib.IsKeyDown(raylib.KEY_S) and (self.box.position[1] + self.box.size[1]) < (config.WINDOW_HEIGTH - config.WINDOW_OFFSET)) {
            self.box.position[1] += self.speed;
        }
    }

    pub fn draw(self: *@This()) void {
        raylib.DrawRectangle(self.box.position[0], self.box.position[1], self.box.size[0], self.box.size[1], raylib.RED);
    }
};
