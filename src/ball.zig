const raylib = @cImport(@cInclude("raylib.h"));
const config = @import("config.zig");
const math = @import("math.zig");
const Enemy = @import("enemy.zig").Enemy;
const Player = @import("player.zig").Player;

pub const Ball = struct {
    box: math.Box,
    velocity: @Vector(2, i32),

    pub fn init(posX: i32, posY: i32) @This() {
        return .{ .box = .{ .position = @Vector(2, i32){ posX, posY }, .size = @Vector(2, i32){ config.BALL_SIZE, config.BALL_SIZE } }, .velocity = @Vector(2, i32){ 2, 1 } };
    }

    pub fn update(self: *@This(), player: *Player, enemy: *Enemy) void {
        if (math.isCollide(self.box, player.box)) {
            self.velocity *= @Vector(2, i32){ -1, -1 };
        }

        if (math.isCollide(self.box, enemy.box)) {
            self.velocity *= @Vector(2, i32){ -1, -1 };
        }

        if (self.box.position[0] < 0 or (self.box.position[0] + self.box.size[0]) > config.WINDOW_WIDTH) {
            self.velocity[0] *= -1;
        }

        if (self.box.position[1] < 0 or (self.box.position[1] + self.box.size[1]) > config.WINDOW_HEIGTH) {
            self.velocity[1] *= -1;
        }

        self.box.position += self.velocity;
    }

    pub fn draw(self: *@This()) void {
        raylib.DrawRectangle(self.box.position[0], self.box.position[1], self.box.size[0], self.box.size[1], raylib.RED);
    }
};
