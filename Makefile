.PHONY: all
all: c++ rust zig-safe zig-fast c

c: c.c
	clang -stdlib=libgcc -O3 $< -o $@

c++: c++.cpp
	clang++ -stdlib=libstdc++ -O3 $< -o $@

rust: rust.rs
	rustc -C opt-level=3 $<

zig-safe: zig.zig
	zig build-exe $< -target x86_64-linux -O ReleaseSafe --name $@

zig-fast: zig.zig
	zig build-exe $< -target x86_64-linux -O ReleaseFast --name $@
