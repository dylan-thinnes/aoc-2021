const std = @import("std");

pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    var allocator = arena.allocator();
    defer arena.deinit();

    const stdin = std.io.getStdIn().reader();

    var depth: usize = 0;
    var c: u8 = 0;

    var history = [_]u8{0} ** 120;
    var list = std.ArrayList(usize).init(allocator);
    while (true) {
        c = stdin.readByte() catch break;
        //std.debug.print("{} {}\n", .{depth, c});
        switch (c) {
            '(','{','[','<' => {
                history[depth] = c;
                depth += 1;
            },
            ')','}',']','>' => {
                const expected: u8 = switch (c) {
                    ')' => '(',
                    '}' => '{',
                    ']' => '[',
                    '>' => '<',
                    else => 0
                };

                depth -= 1;
                if (expected != history[depth]) {
                    depth = 0;
                    while (c != '\n') {
                        c = stdin.readByte() catch break;
                    }
                }
            },
            '\n' => {
                var total: usize = 0;
                while (depth > 0) {
                    depth -= 1;
                    total *= 5;
                    switch (history[depth]) {
                        '(' => total += 1,
                        '{' => total += 3,
                        '[' => total += 2,
                        '<' => total += 4,
                        else => total += 0
                    }
                }

                try list.append(total);
            },
            else => {}
        }
    }

    std.sort.sort(usize, list.items, {}, comptime std.sort.asc(usize));

    var middle = list.items[list.items.len / 2];
    std.debug.print("Middle: {}\n", .{middle});
}
