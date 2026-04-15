; 1. CapsLock to Escape remapping
Capslock::Esc

; 2. Backspace lettermod (Alt Key when held, Backspace when tapped)
; Threshold: 150ms
$*Backspace::
{
    if !KeyWait("Backspace", "T0.15") { ; If held longer than 150ms
        Send("{LAlt Down}")
        KeyWait("Backspace")
        Send("{LAlt Up}")
    } else {
        Send("{Backspace}")
    }
}