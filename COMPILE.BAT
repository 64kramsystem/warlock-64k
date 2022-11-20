SET PATH=%PATH%;C:\C700\BIN;C:\MASM611\BIN
SET LIB=C:\C700\LIB

DEL WARLOCK.EXE

REM The book doesn't explain how to compile the ASM files and how to link.
REM
REM -c:  Don't link
REM -Zf: Make all symbols public
REM
ML -c -Zf DRAWG.ASM
ML -c -Zf RENDERB.ASM
ML -c -Zf SLIVER.ASM

REM Required by CL.EXE
REM
HX\BIN\HDPMI32.EXE

REM For unclear reasons, if the linker is invoked separately, it raises an error that it isn't raised
REM when invoked by the compiler.
REM
REM Book commands:
REM
REM -AM: Medium model
REM -Gs: Remove stack-check calls
REM -G2: 286 instructions
REM
REM Changes:
REM
REM - added `-I`   : Includes
REM - removed `-c` : Link after compiling
REM - set %LIB%    : Libs
REM - removed `-Fc`: Name source/object listing, it seems unnecessary
REM - removed `-Zi`: Prepare for debugging (CodeView)
REM - added `-Fe`  : Executable name
REM
CL -AM -Fc -Gs -G2 -IC700/INCLUDE -FeWARLOCK.EXE DRAWG.OBJ RENDERB.OBJ SLIVER.OBJ *.C
