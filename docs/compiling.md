# compiling

## mingw vs visual studio

@MINGW64@ is enough for most of my native Windows programs and does not
require Visual Studio. Use @VISUAL_STUDIO@ or Visual Studio Build Tools when
a project specifically requires the MSVC compiler, Microsoft libraries or
Windows SDK tools that are not available with mingw-w64.

## mingw runtime dll problem

Programs compiled with mingw-w64 may depend on its GCC and C++ runtime DLLs.
Those DLLs will not normally be present on a Windows machine without the
same toolchain installed.

For example, [mbasecalc](https://www.muquit.com/muquit/software/mbasecalc/mbasecalc.html),
which uses FLTK, needed `libgcc_s_seh-1.dll` next to the executable when I
compiled it with mingw-w64. The version compiled with Visual Studio did not
need the GCC runtime DLL.

## fix: static linking

For GCC and libstdc++, try linking the runtime statically:

```
-static -static-libgcc -static-libstdc++
```

Add these to the linker flags. It does not work with every project.
