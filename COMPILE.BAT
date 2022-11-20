SET PATH=%PATH%;C:\C700\BIN;C:\MASM611\BIN
SET LIB=C:\C700\LIB

DEL WARLOCK.EXE *.OBJ

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

REM Book commands:
REM
REM -c : Don't link
REM -AM: Medium model
REM -Gs: Remove stack-check calls
REM -G2: 286 instructions
REM
REM Changes:
REM
REM - added `-I`   : Includes
REM - set %LIB%    : Libs
REM - removed `-Fc`: Name source/object listing, it seems unnecessary
REM - removed `-Zi`: Prepare for debugging (CodeView)
REM
CL -c -AM -Gs -G2 -IC700/INCLUDE *.C

REM It's possible to link directly via CL:
REM
REM - remove `-c`             : Do link
REM - add `-link GRAPHICS.LIB`: Add required library
REM - add `*.OBJ`             : ASM object files
REM - add `-FeWARLOCK.EXE`    : Set the output filename
REM
REM The empy spaces (between commas) are, in order, the mapfile and the deffile.
REM
LINK DRAWG.OBJ+RENDERB.OBJ+SLIVER.OBJ+graphics.obj+sndlib.obj+warlock.obj,WARLOCK.EXE,,GRAPHICS.LIB,;
