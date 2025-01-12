const std = @import("std");
const sdk = @import("sdk.zig");

pub fn main() void {
    {
        std.debug.print("Print tests\n", .{});
        sdk.print("Platform: {s}, Hardware: {s}\n", .{ @tagName(sdk.THIS_PLATFORM), @tagName(sdk.THIS_HARDWARE) });

        std.debug.print("\n", .{});
    }
}
