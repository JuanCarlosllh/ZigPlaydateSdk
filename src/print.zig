const std = @import("std");

const sdk = @import("sdk.zig");

extern fn write(filedes: c_int, buffer: ?*anyopaque, len: usize) isize;

pub fn print(comptime fmt: []const u8, args: anytype) void {
    platform_print_to_console(fmt, args);
}

fn platform_print_to_console(comptime fmt: []const u8, args: anytype) void {
    switch (comptime sdk.THIS_PLATFORM) {
        .MacOS => {
            var buffer = [_]u8{0} ** 2048;
            const to_print = std.fmt.bufPrint(&buffer, fmt, args) catch return;
            _ = write(1, to_print.ptr, to_print.len);
        },
        .Playdate => {
            @compileError("Platform not yet supported");
        },
    }
}

test "Print to console" {
    platform_print_to_console("Platform:", .{});
}
