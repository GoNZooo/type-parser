const std = @import("std");
const debug = std.debug;
const mem = std.mem;
const heap = std.heap;
const testing = std.testing;
const fmt = std.fmt;
const process = std.process;
const io = std.io;
const fs = std.fs;

const ArrayList = std.ArrayList;

pub fn isStringEqualToOneOf(value: []const u8, compared_values: []const []const u8) bool {
    for (compared_values) |compared_value| {
        if (mem.eql(u8, value, compared_value)) return true;
    }

    return false;
}

pub fn deepCopySlice(
    comptime T: type,
    allocator: *mem.Allocator,
    slice: []const []const T,
) ![]const []const T {
    var ts = try allocator.alloc([]T, slice.len);

    for (ts) |*t, i| t.* = try allocator.dupe(T, slice[i]);

    return ts;
}

pub fn freeStringList(strings: ArrayList([]const u8)) void {
    for (strings.items) |s| strings.allocator.free(s);
    strings.deinit();
}
