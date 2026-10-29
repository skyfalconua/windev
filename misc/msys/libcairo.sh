mkdir -p /c/opt/msys64/__libcairo && cd /c/opt/msys64/__libcairo

# -- -- --

pacman -S --needed \
  mingw-w64-ucrt-x86_64-cairo \
  mingw-w64-ucrt-x86_64-gcc \
  mingw-w64-ucrt-x86_64-pkgconf

# 1. Export list: public cairo_* symbols only
{ echo EXPORTS
  nm -g --defined-only /ucrt64/lib/libcairo.a \
    | awk '$2 ~ /^[TDBR]$/ && $3 ~ /^cairo_/ {print $3}' | sort -u
} > cairo.def

# 2. Link
g++ -shared -o cairo-static.dll cairo.def \
  -Wl,--out-implib,libcairo-static.dll.a \
  -Wl,--whole-archive /ucrt64/lib/libcairo.a -Wl,--no-whole-archive \
  $(pkg-config --static --libs cairo) \
  -lintl -liconv \
  -static -static-libgcc -static-libstdc++

# 3. Verify
wc -l cairo.def                                  # expect a few hundred
objdump -p cairo-static.dll | grep "DLL Name"    # only system DLLs
