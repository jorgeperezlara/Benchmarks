const print = @import("std").debug.print;

pub fn half(num: i64) i64 {
    if (num > 1) {
        return half(@divFloor(num, 2));
    }
    return num;
}

pub fn main() void {
    var j: i64 = 0;
    for (0..10000000000) |i| {
        j += half(@intCast(i));
    }
    print("The result is {}\n", .{j});
}
