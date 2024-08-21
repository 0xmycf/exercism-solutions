const std = @import("std");

// We have to write in the buffer
pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    if (limit == 0) {
        return buffer;
    }
    var sieve: [limit]bool = undefined;
    for (1..limit) |i| {
        sieve[i] = false; // it is unmarked
    }
    sieve[0] = true;
    var buffer_idx: usize = 0;
    for (0..limit) |i| {
        if (sieve[i]) {
            continue;
        }
        const curr_index = i;
        {
            buffer[buffer_idx] = @intCast(curr_index + 1);
            buffer_idx += 1;
        }
        const coef: usize = @intCast(curr_index + 1);
        var multiple: usize = @intCast(curr_index);
        while (multiple < limit) : (multiple += coef) {
            sieve[multiple] = true;
        }
    }
    return buffer[0..buffer_idx];
}
