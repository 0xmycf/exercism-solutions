const std = @import("std");
const mem = std.mem;

const cipher = "zyxwvutsrqponmlkjihgfedcba";

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const encoded = try allocator.alloc(u8, s.len * 2);
    var total: usize = 0;
    var letter: usize = 0;
    var whitespace: usize = 0;
    for (s) |c| {
        var set = false; // no. I dont like this at all :(
        if (c >= 'a' and c <= 'z') {
            encoded[total] = cipher[c - 'a'];
            total += 1;
            letter += 1;
            set = true;
        } else if (c >= 'A' and c <= 'Z') {
            encoded[total] = cipher[c - 'A'];
            total += 1;
            letter += 1;
            set = true;
        } else if (c >= '0' and c <= '9') {
            encoded[total] = c;
            total += 1;
            letter += 1;
            set = true;
        }
        if (set and total != 0 and letter % 5 == 0) {
            encoded[total] = ' ';
            whitespace += 1;
            total += 1;
        }
    }

    return try allocator.realloc(encoded, if (letter % 5 == 0) total - 1 else total);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const decoded = try allocator.alloc(u8, s.len);
    var total: usize = 0;
    for (s) |c| {
        if (c >= 'a' and c <= 'z') {
            decoded[total] = cipher[c - 'a'];
            total += 1;
        } else if (c >= 'A' and c <= 'Z') {
            decoded[total] = cipher[c - 'A'];
            total += 1;
        } else if (c >= '0' and c <= '9') {
            decoded[total] = c;
            total += 1;
        }
    }

    return try allocator.realloc(decoded, total);
}
