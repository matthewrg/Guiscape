;~ Func HWndFromPoint()
;~ 	Local Static $g_tStruct = DllStructCreate($tagPOINT)

;~ 	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

;~ 	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

;~ 	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

;~ 	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

;~ 	;Return _WinAPI_GetClassName($hwnd)
;~ 	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
;~ EndFunc   ;==>HWndFromPoint