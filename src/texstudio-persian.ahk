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