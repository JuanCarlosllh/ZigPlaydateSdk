pub usingnamespace @import("print.zig");

const std = @import("std");
const builtin = @import("builtin");
const root = @import("root");

pub const Platform = enum {
    MacOS,
    Playdate,
};

pub const Hardware = enum {
    AMD64,
    ARM64,
    Playdate,
};

pub const THIS_PLATFORM: Platform = if (@hasDecl(root, "THIS_PLATFORM"))
    root.THIS_PLATFORM
else switch (builtin.os.tag) {
    .macos => .MacOS,
    .linux => .Linux,
    .windows => .Windows,
    .uefi => .UEFI,
    .wasi => .WASM,
    else => @compileError("Platform not yet supported"),
};

pub const THIS_HARDWARE: Hardware = switch (builtin.cpu.arch) {
    .x86_64 => .AMD64,
    .aarch64 => .ARM64,
    .thumb => if (THIS_PLATFORM == .Playdate)
        .Playdate
    else
        @compileError("Hardware not yet supported"),
    else => @compileError("Hardware not yet supported"),
};

pub const IS_DEBUG = builtin.mode == .Debug;

test "Print platform and hardware" {
    const platform = THIS_PLATFORM;
    const hardware = THIS_HARDWARE;

    switch (platform) {
        .MacOS => {
            std.debug.print("Platform: MacOS\n", .{});
        },
        .Playdate => {
            std.debug.print("Platform: Playdate\n", .{});
        },
    }

    switch (hardware) {
        .AMD64 => {
            std.debug.print("Hardware: AMD64\n", .{});
        },
        .ARM64 => {
            std.debug.print("Hardware: ARM64\n", .{});
        },
        .Playdate => {
            std.debug.print("Hardware: Playdate\n", .{});
        },
    }
}
