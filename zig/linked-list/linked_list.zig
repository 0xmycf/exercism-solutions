const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        // Please implement the doubly linked `Node` (replacing each `void`).
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        // Please implement the fields of the linked list (replacing each `void`).
        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        const Self = @This();

        // Please implement the below methods.
        // You need to add the parameters to each method.
        pub fn push(self: *Self, node: *Node) void {
            // Please implement this method.
            node.prev = self.last;
            node.next = null;
            if (self.len > 0)
                self.last.?.next = node;
            self.last = node;

            if (self.len == 0) {
                self.first = node;
            }
            self.len += 1;
        }

        // Please implement this method.
        // It must return an optional pointer to a Node.
        pub fn pop(self: *Self) ?*Node {
            const ret = self.last;

            if (self.len == 0) return ret;
            self.len -= 1;

            self.last = self.last.?.prev;

            return ret;
        }

        pub fn shift(self: *Self) ?*Node {
            const ret = self.first;

            if (self.len == 0) return ret;

            self.first = self.first.?.next;
            self.len -= 1;

            return ret;
        }

        pub fn unshift(self: *Self, node: *Node) void {
            node.prev = null;
            if (self.len > 0)
                self.first.?.prev = node;
            node.next = self.first;
            self.first = node;

            if (self.len == 0) {
                self.last = node;
            }
            self.len += 1;
        }

        pub fn delete(self: *Self, elem: *Node) void {
            // Please implement this method.
            // It must modify the list only when it contains the given node.
            var curr = self.first;
            while (curr) |node| : (curr = node.next) {
                if (node.data != elem.data) continue;

                if (node.next) |nxt| nxt.prev = node.prev;
                if (node.prev) |prv| prv.next = node.next;
                if (self.last == node) self.last = node.prev;
                if (self.first == node) self.first = node.next;

                self.len -= 1;
                return;
            }
        }
    };
}
