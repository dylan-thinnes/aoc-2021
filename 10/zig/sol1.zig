const std = @import("std");

var history = [_]u8{0} ** 120;

pub fn main () !void {
    const stdin = std.io.getStdIn().reader();

    var depth: usize = 0;
    var c: u8 = 0;
    var total: usize = 0;

    while (true) {
        c = stdin.readByte() catch break;
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
                    switch (c) {
                        ')' => total += 3,
                        '}' => total += 1197,
                        ']' => total += 57,
                        '>' => total += 25137,
                        else => {}
                    }

                    depth = 0;
                    while (c != '\n') {
                        c = stdin.readByte() catch break;
                    }
                }
            },
            '\n' => {
                depth = 0;
            },
            else => {}
        }
    }

    std.debug.print("Total: {}\n", .{total});
}
