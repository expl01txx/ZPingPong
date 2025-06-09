pub const Box = struct {
    position: @Vector(2, i32),
    size: @Vector(2, i32),

    pub fn init(x: i32, y: i32, width: i32, heigth: i32) @This() {
        return .{ .position = .Vector2{
            .x = x,
            .y = y,
        }, .size = .Vector2{
            .x = width,
            .y = heigth,
        } };
    }
};

pub fn isCollide(a: Box, b: Box) bool {
    return a.position[0] < b.position[0] + b.size[0] and
        a.position[0] + a.size[0] > b.position[0] and
        a.position[1] < b.position[1] + b.size[1] and
        a.position[1] + a.size[1] > b.position[1];
}
