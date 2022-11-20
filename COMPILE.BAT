SET PATH=%PATH%;C:\C700\BIN;C:\MASM611\BIN
SET LIB=C:\C700\LIB

DEL WARLOCK.EXE *.OBJ *.MAP

REM The book doesn't explain how to compile the ASM files and how to link.
REM See note in the CL full linking comment, about the relationship with ML and CL.
REM
MASM DRAWG.ASM
MASM RENDERB.ASM
MASM SLIVER.ASM

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

REM It's possible to link directly via CL.
REM Note that:
REM
REM - `-link GRAPHICS.LIB` must be the last parameter
REM - the ASM files *must* be compiled via `ML (-c)`, otherwise, the compiler doesn't find the
REM   symbols exported by the ASM object files; this is due, for unclear reasons, to the flag
REM   `/Zm` (Enable MASM 5.10 compatibility) that MASM passes to ML.
REM
REM CL -AM -Gs -G2 -IC700/INCLUDE -FeWARLOCK.EXE DRAWG.OBJ RENDERB.OBJ SLIVER.OBJ *.C -link GRAPHICS.LIB

REM The empy spaces (between separators) are, in order, the mapfile and the deffile.
REM
LINK DRAWG.OBJ+RENDERB.OBJ+SLIVER.OBJ+graphics.obj+sndlib.obj+warlock.obj,WARLOCK.EXE,,GRAPHICS.LIB,;
