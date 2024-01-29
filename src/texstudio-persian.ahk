#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_exe texstudio.exe")
$$::{
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
    if(LangId = 0xF03A0429) {
        Send "{Alt Down}{Shift Down}{Shift Up}{Alt Up}{$}"
    } else {
        Send "{$}"
    }
}

GetCurrentKeyboardLayout() {
    hwnd := DllCall("GetForegroundWindow")
    if hwnd == 0
        return 0
    threadID := DllCall("GetWindowThreadProcessId", "UInt", hwnd, "UInt", 0)
    return DllCall("GetKeyboardLayout", "UInt", threadID, "UInt")
}

ReleaseCtrlIfNotPhysicallyDown() {
	; https://stackoverflow.com/a/49034365/1539231
	If GetKeyState("Ctrl")           ; If the OS believes the key to be in (logical state),
	{
		If !GetKeyState("Ctrl","P")  ; but the user isn't physically holding it down (physical state)
		{
			Send "{Ctrl Up}"
		}
	}
}

^1::{
	A_MenuMaskKey := ""
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
    if(LangId = 0xF03A0429) {
        old_clip := ClipboardAll() ; Save all clipboard content
        A_Clipboard := "`n\lr{}`n"
        Send "^v"
		Sleep 100 ; Wait a bit for Ctrl+V to be processed 
        A_Clipboard := old_clip ; Restore previous clipboard content
        Send "{Up}{End}{Left}{Alt Down}{Shift Down}{Shift Up}"
		Sleep 10
		Send "{Alt Up}"		
		ReleaseCtrlIfNotPhysicallyDown()
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
		Sleep 10
		Send "{Alt Up}"
		ReleaseCtrlIfNotPhysicallyDown()
    }
}
^`::{
	A_MenuMaskKey := ""
    LangId := GetCurrentKeyboardLayout()
    ; Enlgish: 0x4090409
    ; Persian: 0xF03A0429
    if(LangId = 0x4090409) {
		Send "{Down}{Home}{Alt Down}{Shift Down}{Shift Up}"
		Sleep 10
		Send "{Alt Up}"
		ReleaseCtrlIfNotPhysicallyDown()
    }
}

#HotIf