const std = @import("std");
const mem = std.mem;

const cipher = "zyxwvutsrqponmlkjihgfedcba";

fn code(c: u8) ?u8 {
    return switch (c) {
        'a'...'z' => cipher[c - 'a'],
        'A'...'Z' => cipher[c - 'A'],
        '0'...'9' => c,
        else => null,
    };
}

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const encoded = try allocator.alloc(u8, s.len + @divFloor(s.len, 5) + 1);
    var total: usize = 0;
    var letter: usize = 0;
    for (s) |c| {
        if (code(c)) |new| {
            encoded[total] = new;
            total += 1;
            letter += 1;

            if (letter == 5) {
                encoded[total] = ' ';
                total += 1;
                letter = 0;
            }
        }
    }

    return try allocator.realloc(encoded, if (letter == 0) total - 1 else total);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const decoded = try allocator.alloc(u8, s.len);
    var total: usize = 0;
    for (s) |c| {
        if (code(c)) |new| {
            decoded[total] = new;
            total += 1;
        }
    }

    return try allocator.realloc(decoded, total);
}
