# openssl zig package

This is [OpenSSL](https://github.com/openssl/openssl) 3.3.2 ported to the Zig Build System.

## Usage

Add the package to your `build.zig.zon` and link the static library:

```zig
const openssl = b.dependency("openssl", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.linkLibrary(openssl.artifact("openssl"));
```

Then build as usual:

```sh
zig build
```

No system OpenSSL, perl, or configure step is required for a normal build — the
generated assembly and configure-derived headers are committed under `gen/`.

## Supported targets

Assembly and per-target headers are pre-generated and checked in for:

| Arch    | Linux | macOS | Windows |
| ------- | :---: | :---: | :-----: |
| x86_64  |   ✅   |   ✅   |   ✅ (mingw) |
| aarch64 |   ✅   |   ✅   |   ✅ (mingw) |

Building for any other target panics at configure time with
"Unsupported target for OpenSSL: no asm variant configured". The variant table
lives in `config.zig` (`config.variants`).

## Regenerating (maintainers)

The committed files under `gen/` — perlasm output plus the headers and sources
`util/dofile.pl` fills from templates — are refreshed with:

```sh
zig build gen
```

This shells out to `perl` and a POSIX `sh`, running each variant's perlasm
scripts and OpenSSL's `Configure`/`dofile.pl` against the upstream source
tarball, and writes the results straight into the source tree. Normal builds
consume the committed output and need neither perl nor a configure step. The
generation logic lives in `generate.zig` and `config.zig`; `mingw-arm64.conf`
supplies the aarch64-windows Configure target that OpenSSL 3.3.2 lacks.

## Zig version compatibility

- `0.16.x` (minimum required)

## Anti-Endorsement

I do not endorse openssl. I think it is a pile of trash. My motivation for this
project is because it is a dependency of CPython, which is a dependency of the
most active YouTube downloader, [ytdlp](https://github.com/yt-dlp/yt-dlp).
