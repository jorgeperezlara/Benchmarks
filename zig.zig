const print = @import("std").debug.print;

pub fn half(num: i64) i64 {
    var mut_num = num;
    if (mut_num > 1) {
        mut_num = half(@divFloor(mut_num, 2));
    }
    return mut_num;
}

pub fn main() void {
    var j: i64 = 0;
    for (0..10000000000) |i| {
        const result: i64 = @intCast(i);
        j = j + half(result);
    }
    print("The result is {}\n", .{j});
}
