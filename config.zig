const std = @import("std");

const PerlInput = struct {
    input: []const u8,
};

const arm_aarch64_input = [_][]const u8{
    "crypto/md5/asm/md5-aarch64",

    //"crypto/armv4cpuid",
    //"crypto/modes/asm/ghash-armv4",
    "crypto/modes/asm/ghashv8-armx",
    "crypto/modes/asm/aes-gcm-armv8-unroll8_64",
    "crypto/modes/asm/aes-gcm-armv8_64",
    "crypto/sm3/asm/sm3-armv8",
    "crypto/sm4/asm/vpsm4-armv8",
    "crypto/sm4/asm/vpsm4_ex-armv8",
    "crypto/sm4/asm/sm4-armv8",
    "crypto/chacha/asm/chacha-armv8",
    //"crypto/chacha/asm/chacha-armv4",
    "crypto/chacha/asm/chacha-armv8-sve",
    //"crypto/poly1305/asm/poly1305-armv4",
    "crypto/poly1305/asm/poly1305-armv8",
    //"crypto/sha/asm/sha256-armv4",
    "crypto/sha/asm/sha512-armv8",
    //"crypto/sha/asm/keccak1600-armv4",
    "crypto/sha/asm/sha1-armv8",
    "crypto/sha/asm/keccak1600-armv8",
    //"crypto/sha/asm/sha512-armv4",
    //"crypto/sha/asm/sha1-armv4-large",
    "crypto/arm64cpuid",
    "crypto/perlasm/arm-xlate",
    "crypto/aes/asm/vpaes-armv8",
    "crypto/aes/asm/aesv8-armx",
    //"crypto/aes/asm/bsaes-armv7",
    //"crypto/aes/asm/aes-armv4",
    "crypto/aes/asm/bsaes-armv8",
    "crypto/bn/asm/armv8-mont",
    //"crypto/bn/asm/armv4-mont",
    //"crypto/bn/asm/armv4-gf2m",

    "crypto/ec/asm/ecp_nistz256-armv8",
    //"crypto/ec/asm/ecp_nistz256-armv4",
    "crypto/ec/asm/ecp_sm2p256-armv8",

};

const x86_input = [_][]const u8{
    "crypto/aes/asm/aes-x86_64",
    "crypto/aes/asm/aesni-mb-x86_64",
    "crypto/aes/asm/aesni-sha1-x86_64",
    "crypto/aes/asm/aesni-sha256-x86_64",
    "crypto/aes/asm/aesni-x86_64",
    "crypto/aes/asm/bsaes-x86_64",
    "crypto/aes/asm/vpaes-x86_64",

    "crypto/bn/asm/rsaz-x86_64",

    "crypto/camellia/asm/cmll-x86_64",
    "crypto/chacha/asm/chacha-x86_64",
    "crypto/ec/asm/ecp_nistz256-x86_64",
    "crypto/ec/asm/x25519-x86_64",
    "crypto/ec/asm/x25519-x86_64",
    "crypto/md5/asm/md5-x86_64",
    "crypto/modes/asm/aesni-gcm-x86_64",
    "crypto/modes/asm/ghash-x86_64",
    "crypto/poly1305/asm/poly1305-x86_64",
    "crypto/rc4/asm/rc4-md5-x86_64",
    "crypto/rc4/asm/rc4-x86_64",
    "crypto/sha/asm/keccak1600-x86_64",
    "crypto/sha/asm/sha1-mb-x86_64",
    "crypto/sha/asm/sha1-x86_64",
    "crypto/sha/asm/sha256-mb-x86_64",
    //"crypto/sha/asm/sha256-x86_64",
    "crypto/sha/asm/sha512-x86_64",
    "crypto/whrlpool/asm/wp-x86_64",

    "crypto/x86_64cpuid",
    "crypto/bn/asm/x86_64-gf2m",
    "crypto/bn/asm/x86_64-mont5",
    "crypto/bn/asm/x86_64-mont",
    "crypto/bn/asm/rsaz-avx2",
    "crypto/bn/asm/rsaz-2k-avx512",
    "crypto/bn/asm/rsaz-3k-avx512",
    "crypto/bn/asm/rsaz-4k-avx512",

    "crypto/modes/asm/aes-gcm-avx512",
};

pub const Variant = struct { arch: std.Target.Cpu.Arch, os: std.Target.Os.Tag, flavor: []const u8, perl: []const []const u8 };

pub const variants = [_]Variant{
    Variant{ .os = .linux, .arch = .x86_64, .flavor = "linux64", .perl = &x86_input },
    Variant{ .os = .windows, .arch = .x86_64, .flavor = "win64", .perl = &x86_input },

    Variant{ .os = .linux, .arch = .aarch64, .flavor = "linux64", .perl = &arm_aarch64_input },
    Variant{ .os = .macos, .arch = .aarch64, .flavor = "ios64", .perl = &arm_aarch64_input },
};
