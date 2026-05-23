; appdata/roaming/microsoft/windows/start menu/programs/startup/script.ahk

CapsLock::Escape

; make bs act like alt while held, allows multiple actions, e.g.
; alt+{key, key, key...}
; if released wo intervening key, revert to bs

; L1 ends hook on 1 intervening key press
ih := InputHook("L1") 
; makes everything an intervening key press, not just printable characters 
ih.KeyOpt("{All}", "E") 
; calls OnEnd() on intervening keypress (and bs up)
ih.OnEnd := OnEnd 

OnEnd(ih) {
    ; only send on intervening key, not bs up
    ; not sending LAlt Up allows multiple actions wo releasing bs
    if ih.EndReason = "EndKey" 
        Send("{LAlt Down}{" ih.EndKey "}")
}

$Backspace::
{
    global ih
    ih.Start()
}

$Backspace up::
{
    global ih
    ih.Stop()
    ; release alt if there was intervening key
    if ih.EndReason = "EndKey"
        Send("{LAlt Up}")
    ; revert to bs if no intervening key
    else
        Send("{Backspace}")
}
