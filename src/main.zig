const raylib = @cImport(@cInclude("raylib.h"));
const config = @import("config.zig");
const Player = @import("player.zig").Player;
const Enemy = @import("enemy.zig").Enemy;
const Ball = @import("ball.zig").Ball;

const std = @import("std");

pub fn main() !void {
    const screenWidth = config.WINDOW_WIDTH;
    const screenHeigth = config.WINDOW_HEIGTH;

    var player = Player.init(config.WINDOW_OFFSET, config.WINDOW_OFFSET);
    var enemy = Enemy.init((config.WINDOW_WIDTH - config.WINDOW_OFFSET) - config.PADDLE_WIDTH, config.WINDOW_OFFSET);
    var ball = Ball.init(config.WINDOW_WIDTH / 2 - config.BALL_SIZE / 2, config.WINDOW_HEIGTH / 2 - config.BALL_SIZE / 2);

    raylib.InitWindow(screenWidth, screenHeigth, "Hello");
    raylib.SetTargetFPS(60);

    while (!raylib.WindowShouldClose()) {

        // update
        player.update();
        enemy.update(&ball);
        ball.update(&player, &enemy);

        raylib.BeginDrawing();
        raylib.ClearBackground(raylib.BLACK);
        // draw
        player.draw();
        enemy.draw();
        ball.draw();

        raylib.EndDrawing();
    }

    raylib.CloseWindow();
}
