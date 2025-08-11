#Requires AutoHotkey v2.0

; === macOS-like keybindings (Cmd = Win key) ===

; Move to beginning of line (Ctrl + A)
$^a::Send("{Home}")    ; '$' prevents retriggering from Send("^a")

; Move to end of line (Ctrl + E)
^e::Send("{End}")

; Select all (Cmd + A → Ctrl + A)
#a::SendInput("^a")

; Copy (Cmd + C → Ctrl + C)
#c::Send("^c")

; Paste (Cmd + V → Ctrl + V)
#v::Send("^v")

; Cut (Cmd + X → Ctrl + X)
#x::Send("^x")

; Save (Cmd + S → Ctrl + S)
#s::Send("^s")

; Delete (Cmd + Delete → Delete)
#Delete::Send("{Delete}")

; Undo (Cmd + Z → Ctrl + Z)
#z::Send("^z")

; Redo (Cmd + Shift + Z → Ctrl + Shift + Z)
#+z::Send("^+z")

; Close window / Quit (Cmd + Q → Alt + F4)
#q::Send("!{F4}")
