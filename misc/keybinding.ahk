#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; macOS-like keyboard shortcuts for Windows VDI environments
; ==============================================================================

; ------------------------------------------------------------------------------
; Editing: Cut, Copy, Paste, Undo, Redo, Select All
; ------------------------------------------------------------------------------

#x::SendEvent("^x")       ; Cmd+X       -> Cut
#c::SendEvent("^c")       ; Cmd+C       -> Copy
#v::SendEvent("^v")       ; Cmd+V       -> Paste

#z::SendEvent("^z")       ; Cmd+Z       -> Undo
#y::SendEvent("^y")       ; Cmd+Y       -> Redo
#+z::SendEvent("^y")      ; Cmd+Shift+Z -> Redo

#a::SendEvent("^a")       ; Cmd+A       -> Select All
#p::SendEvent("^p")       ; Cmd+P       -> Print

; ------------------------------------------------------------------------------
; File and window management
; ------------------------------------------------------------------------------

#s::SendEvent("^s")       ; Cmd+S       -> Save
#o::SendEvent("^o")       ; Cmd+O       -> Open
#n::SendEvent("^n")       ; Cmd+N       -> New
#w::SendEvent("^w")       ; Cmd+W       -> Close tab
#q::SendEvent("^q")       ; Cmd+Q       -> Close application (if supported)

#r::SendEvent("^r")       ; Cmd+R       -> Refresh
#+r::SendEvent("^+r")     ; Cmd+Shift+R -> Force Refresh

#+e::Run("explorer.exe")  ; Cmd+Shift+E -> Open File Explorer

; ------------------------------------------------------------------------------
; Search and navigation
; ------------------------------------------------------------------------------

#f::SendEvent("^f")       ; Cmd+F -> Find
#g::SendEvent("^g")       ; Cmd+G -> Find Next
#h::SendEvent("^h")       ; Cmd+H -> Replace

; ------------------------------------------------------------------------------
; Text formatting / Misc
; ------------------------------------------------------------------------------

#b::SendEvent("^b")       ; Cmd+B -> Bold
#i::SendEvent("^i")       ; Cmd+I -> Italic
#u::SendEvent("^u")       ; Cmd+U -> Underline

#/::SendEvent("^/")       ; Cmd+/ → Comment/Uncomment

#d::SendEvent("^d")       ; Cmd+D
#e::SendEvent("^e")       ; Cmd+E
#j::SendEvent("^j")       ; Cmd+J
#k::SendEvent("^k")       ; Cmd+K
#l::SendEvent("^l")       ; Cmd+L
#m::SendEvent("^m")       ; Cmd+M

; ------------------------------------------------------------------------------
; Browser and editor zoom
; ------------------------------------------------------------------------------

#+-::SendEvent("^+-")     ; Cmd+Shift+- -> Ctrl+Shift+-
#+=::SendEvent("^+=")     ; Cmd+Shift+= -> Ctrl+Shift+=
#+0::SendEvent("^+0")     ; Cmd+Shift+0 -> Ctrl+Shift+0

#-::SendEvent("^-")
#=::SendEvent("^=")
#0::SendEvent("^0")

; ------------------------------------------------------------------------------
; Development tools and application shortcuts
; ------------------------------------------------------------------------------

#t::SendEvent("^!t")   ; Cmd+T       -> New terminal in tab
#+p::SendEvent("^+p")  ; Cmd+Shift+P -> vscode command palette
#!p::SendEvent("^!p")  ; Cmd+Alt+P   -> command runner
#+d::SendEvent("^+d")  ; Cmd+Shift+D -> duplicate line

; ------------------------------------------------------------------------------
; CapsLock: short press switches input language; long press toggles CapsLock
; ------------------------------------------------------------------------------

*CapsLock::
{
  if KeyWait("CapsLock", "T0.3") {
    SendEvent("{LCtrl Down}{LShift Down}{LShift Up}{LCtrl Up}")
  } else {
    SetCapsLockState(!GetKeyState("CapsLock", "T"))
    KeyWait("CapsLock") ; Wait for release to prevent auto-repeat
  }
}
