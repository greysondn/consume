rem requires:
rem     python 3.x
rem     fonttools (a python 3 library)
rem
rem this is long, so careful if you choose to poke it!
rem
rem the base font is at
rem ..\doc\fonts\hack\Hack-Regular.ttf
rem
rem a list of symbols we want in our subset
rem is at
rem ..\config\scripts\subset-hack.txt
rem
rem the up caret just tells windows we want to continue on the next line
rem
pyftsubset ^
    "..\doc\fonts\hack\Hack-Regular.ttf"            ^
    --text-file="..\config\scripts\subset-hack.txt" ^
    --output-file="..\assets\fonts\hack.ttf"        ^
    --recommended-glyphs                            ^
    --layout-features="*"                           ^
    --hinting                                       ^
    --drop-tables=""                                ^
    --passthrough-tables                            ^
    --legacy-kern                                   ^
    --name-IDs="*"                                  ^
    --name-legacy                                   ^
    --glyph-names                                   ^
    --legacy-cmap                                   ^
    --symbol-cmap
    
rem and wait at the end so we can examine output
pause