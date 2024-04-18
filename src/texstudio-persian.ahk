#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe texstudio.exe")

GetCurrentKeyboardLayout() {
    hwnd := DllCall("GetForegroundWindow")
    if hwnd == 0
        return 0
    threadID := DllCall("GetWindowThreadProcessId", "UInt", hwnd, "UInt", 0)
    return DllCall("GetKeyboardLayout", "UInt", threadID, "UInt")
}

IsKeyboardLayoutPersian() {
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
	return LangId = 0xF03A0429
}

ChangeKeyboardLayout() {
	/*
		; simply sending Alt+Shift does not work since some hotkeys may activate 
		; while the ctrl is down. Ctrl+Alt+Shift does nothing!
		Send "{Alt Down}{Shift}{Alt up}" 
	*/
	
	INPUTLANGCHANGE_FORWARD := 0x2
	WM_INPUTLANGCHANGEREQUEST := 0x0050
	PostMessage WM_INPUTLANGCHANGEREQUEST, INPUTLANGCHANGE_FORWARD, , , "A"	
}

$$::{
    if IsKeyboardLayoutPersian()
		ChangeKeyboardLayout()
	Send "{$}"
}

\::{
	if IsKeyboardLayoutPersian()
		ChangeKeyboardLayout()
	Send "\"
}

^1::{
    if IsKeyboardLayoutPersian() {
        old_clip := ClipboardAll() ; Save all clipboard content
        A_Clipboard := "`n\lr{}`n"
		KeyWait "Control"
        Send "^v"
		Sleep 100 ; Wait a bit for Ctrl+V to be processed 
        A_Clipboard := old_clip ; Restore previous clipboard content
		Send "{Up}{End}{Left}"
		ChangeKeyboardLayout()
    }
}

^2::{
	A_MenuMaskKey := ""
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
    if(LangId = 0xF03A0429) {
        old_clip := ClipboardAll() ; Save all clipboard content
        A_Clipboard := "%`n\footnote{\lr{}}`n"
        Send "^v"
        Sleep 100 ; Wait a bit for Ctrl+V to be processed
        A_Clipboard := old_clip ; Restore previous clipboard content	
        Send "{Up}{End}{Left 2}{Alt Down}{Shift Down}{Shift Up}"
		Sleep 20
		Send "{Alt Up}"
    }
}
^`::{
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
    if(LangId = 0x4090409) {
		KeyWait "Control"
		Send "{Down}{Home}"
		ChangeKeyboardLayout()
    }
}

#HotIf