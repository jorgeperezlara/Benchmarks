# Benchmarking systems programming languages

After some time learning high-level, garbage collected programming languages, and mostly attracted by Rust, I decided to give a shot to a new breath of programming languages that were meant to replace C/C++. Nowadays, according to their popularity/maturity, the most likely contenders seem to be Rust and Zig.

For all of the four, C, C++, Rust and Zig, I've read claims online about how theoretically each should be the most performant among all:

* **C/C++:** Because of historical unsafety and theoretical performance. While I strongly dislike that the language lacks support for `restrict` in C++ or SIMD by default, the truth is compiler extensions make up for this lackings.
* **Rust:** Easy aliasing, strong type rules and safety measures should make for easier optimizations. Also, many safety checks can be optimized away by the compilers if deemed redundant/unnecessary.
* **Zig:** Strong focus on flexibility, performance and simplicity.

With this in mind, I went on to perform my own benchmark, a simple, recursive loop division that makes little sense as a function itself, but that it's interesting nonetheless.

These are my specs:

```
             .',;::::;,'.                jorgeperezlara@jorgegigabyte 
         .';:cccccccccccc:;,.            ---------------------------- 
      .;cccccccccccccccccccccc;.         OS: Fedora Linux 40 (Workstation Edition) x86_64 
    .:cccccccccccccccccccccccccc:.       Host: G5 KD 
  .;ccccccccccccc;.:dddl:.;ccccccc;.     Kernel: 6.9.5-200.fc40.x86_64 
 .:ccccccccccccc;OWMKOOXMWd;ccccccc:.    Uptime: 15 hours, 49 mins 
.:ccccccccccccc;KMMc;cc;xMMc:ccccccc:.   Packages: 11110 (rpm), 1033 (flatpak) 
,cccccccccccccc;MMM.;cc;;WW::cccccccc,   Shell: bash 5.2.26 
:cccccccccccccc;MMM.;cccccccccccccccc:   Resolution: 1920x1080 
:ccccccc;oxOOOo;MMM0OOk.;cccccccccccc:   DE: GNOME 46.2 
cccccc:0MMKxdd:;MMMkddc.;cccccccccccc;   WM: Mutter 
ccccc:XM0';cccc;MMM.;cccccccccccccccc'   WM Theme: Adwaita 
ccccc;MMo;ccccc;MMW.;ccccccccccccccc;    Theme: Adwaita [GTK2/3] 
ccccc;0MNc.ccc.xMMd:ccccccccccccccc;     Icons: Adwaita [GTK2/3] 
cccccc;dNMWXXXWM0::cccccccccccccc:,      Terminal: BlackBox 
cccccccc;.:odl:.;cccccccccccccc:,.       CPU: 11th Gen Intel i5-11400H (12) @ 4.500GHz 
:cccccccccccccccccccccccccccc:'.         GPU: Intel TigerLake-H GT1 [UHD Graphics] 
.:cccccccccccccccccccccc:;,..            GPU: NVIDIA GeForce RTX 3060 Mobile / Max-Q 
  '::cccccccccccccc::;,.                 Memory: 6389MiB / 15764MiB 
```

Now, these are the results:

```
$ clang++ -stdlib=libstdc++ -O3 c++.cpp
$ time ./c++ 
The result is 9999999999
real    1m59.314s
user    1m59.099s
sys     0m0.003s
```

```
$ rustc -C opt-level=3 rust.rs
$ time ./rust
The result is 9999999999
real    2m3.918s
user    2m3.764s
sys     0m0.002s
```

```
$ zig build-exe zig.zig -target x86_64-linux -O ReleaseSafe
$ time ./zig
The result is 9999999999

real    1m38.193s
user    1m38.070s
sys     0m0.003s
```

```
$ zig build-exe zig.zig -target x86_64-linux -O ReleaseFast
$ time ./zig
The result is 9999999999

real    1m56.232s
user    1m56.090s
sys     0m0.003s
```

```
$ clang -stdlib=libgcc -O3 c.c
$ time ./c
The result is 9999999999
real    1m58.715s
user    1m58.543s
sys     0m0.002s
```

I'm very surprised at the excellent performance of safe Zig, which, suppossedly, should be slower than fast Zig (and C++, and Rust).

All in all, I can safely say after several runs, that indeed the Zig version is consistently the most performant (and significantly so for the safe Zig one); and the Rust one slightly **(but consistenly)** less than the C++ one. You may find a summary table below:

|                      | Total time (s) | Deviation from the most performant (s) | Deviation from the most performant (×) |
| :------------------- | :------------- | :------------------------------------- | :-------------------------------------- |
| **C++**        | 119.102        | 21.029                                 | 1.214                                   |
| **C**               | 118.545        | 20.472                                 | 1.209                                   |
| **Rust**       | 123.766        | 25.693                                 | 1.262                                   |
| **Zig (safe)** | 98.073         | 0.000                                  | 1.000                                   |
| Zig (fast)           | 116.093        | 18.020                                 | 1.184                                   |

I can also conclude that, **for this benchmark**, if any Rust supporter believes a 4% decrease in performance for Rust is not significant, I believe it's coherent to say that a 31.3% performance decrease is definitely **not insignificant**, and that rust is by far the faster among all.

While the performance differnce between C++ and fast Zig; and C++ and Rust is not too big (in this machine), the difference between fast Zig and Rust is around 6.6%, and this might grow larger in embedded or lower-power systems.
