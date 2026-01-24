const std = @import("std");
const config = @import("./config.zig");

pub fn main(init: std.process.Init) !void {
    var args = try init.minimal.args.iterateAllocator(init.arena.allocator());
    _ = args.skip();
    const openssl_root = args.next().?;
    for (config.variants) |v| {
        for (v.perl) |asm_path| {
            var step_arena = std.heap.ArenaAllocator.init(init.gpa);
            defer step_arena.deinit();
            var env_map: std.process.Environ.Map = .init(step_arena.allocator());
            try env_map.put("CC", "clang-18"); // code is built around assuming clang ... 

            const name = std.Io.Dir.path.basename(asm_path);
            const input_file = try std.fmt.allocPrint(step_arena.allocator(), "{s}/{s}.pl", .{ openssl_root, asm_path });
            const output_folder = try std.fmt.allocPrint(step_arena.allocator(), "gen/{s}", .{v.flavor});
            const output_file = try std.fmt.allocPrint(step_arena.allocator(), "{s}/{s}.s", .{ output_folder, name });
            try std.Io.Dir.cwd().createDirPath(init.io, output_folder);

            const argv = [_][]const u8{ "perl", input_file, v.flavor, output_file };
            const res = try std.process.run(step_arena.allocator(), init.io, .{ .argv = &argv, .environ_map = &env_map });
            if (res.stdout.len > 0)
                std.log.info("{s}", .{res.stdout});
            if (res.stderr.len > 0)
                std.log.err("{s}", .{res.stderr});
        }
    }
}
