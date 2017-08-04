
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc
include wininet.inc
includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib
includelib wininet.lib
DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

IDD_DIALOG1			equ 101

;#########################################################################

.data?
hopen dd ?
hcon dd ?
hInstance			dd ?
bytesread dd ?
htext dd ?
hh dd ?
.data
ag db "asm is cool",0
msg db "something wrong",0
host db 5000 dup(0)
idata db 10000 dup(0)
;#########################################################################
