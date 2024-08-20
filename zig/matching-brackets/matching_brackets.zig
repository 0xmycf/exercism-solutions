const std = @import("std");
const mem = std.mem;

// pub fn main() void {
//     var alloc = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//     defer alloc.deinit();
//     const res = isBalanced(alloc.allocator(), "(()") catch true;
//     std.debug.print("{any}", .{res});
// }

const Stack = std.ArrayList(u8);

fn isOpening(c: u8) bool {
    return c == '[' or c == '{' or c == '(';
}

fn isClosing(c: u8) bool {
    return c == ']' or c == '}' or c == ')';
}

fn opposite(c: u8) u8 {
    return switch (c) {
        '{' => '}',
        '(' => ')',
        '[' => ']',
        ' ' => ' ', // error
        else => unreachable,
    };
}

pub fn isBalanced(alloc: mem.Allocator, s: []const u8) !bool {
    var stack = Stack.init(alloc);
    defer stack.deinit();

    for (s) |c| {
        if (isOpening(c)) {
            try stack.append(c);
        } else if (isClosing(c)) {
            const last = stack.popOrNull() orelse ' ';
            if (c != opposite(last)) {
                return false;
            }
        }
    }
    return stack.items.len == 0;
}
