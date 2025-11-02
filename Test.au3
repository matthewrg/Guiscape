
#include <WindowsStylesConstants.au3>
#include <GUIConstantsEx.au3>

Global $form = GUICreate("Form", 300, 300)

GUISetState(@SW_SHOW, $form)

Local Const $allStyles[] = [$WS_EX_ACCEPTFILES, _
		$WS_EX_APPWINDOW, _
		$WS_EX_CLIENTEDGE, _
		$WS_EX_COMPOSITED, _
		$WS_EX_CONTEXTHELP, _
		$WS_EX_CONTROLPARENT, _
		$WS_EX_DLGMODALFRAME, _
		$WS_EX_LAYERED, _
		$WS_EX_LAYOUTRTL, _
		$WS_EX_LEFT, _
		$WS_EX_LEFTSCROLLBAR, _
		$WS_EX_LTRREADING, _
		$WS_EX_MDICHILD, _
		$WS_EX_NOACTIVATE, _
		$WS_EX_NOINHERITLAYOUT, _
		$WS_EX_NOPARENTNOTIFY, _
		$WS_EX_NOREDIRECTIONBITMAP, _
		$WS_EX_OVERLAPPEDWINDOW, _
		$WS_EX_PALETTEWINDOW, _
		$WS_EX_RIGHT, _
		$WS_EX_RIGHTSCROLLBAR, _
		$WS_EX_RTLREADING, _
		$WS_EX_STATICEDGE, _
		$WS_EX_TOOLWINDOW, _
		$WS_EX_TOPMOST, _
		$WS_EX_TRANSPARENT, _
		$WS_EX_WINDOWEDGE, _
		$GUI_WS_EX_PARENTDRAG]

Local Const $names[] = ["WS_EX_ACCEPTFILES        ", _
		"WS_EX_APPWINDOW          ", _
		"WS_EX_CLIENTEDGE         ", _
		"WS_EX_COMPOSITED         ", _
		"WS_EX_CONTEXTHELP        ", _
		"WS_EX_CONTROLPARENT      ", _
		"WS_EX_DLGMODALFRAME      ", _
		"WS_EX_LAYERED            ", _
		"WS_EX_LAYOUTRTL          ", _
		"WS_EX_LEFT               ", _
		"WS_EX_LEFTSCROLLBAR      ", _
		"WS_EX_LTRREADING         ", _
		"WS_EX_MDICHILD           ", _
		"WS_EX_NOACTIVATE         ", _
		"WS_EX_NOINHERITLAYOUT    ", _
		"WS_EX_NOPARENTNOTIFY     ", _
		"WS_EX_NOREDIRECTIONBITMAP", _
		"WS_EX_OVERLAPPEDWINDOW   ", _
		"WS_EX_PALETTEWINDOW      ", _
		"WS_EX_RIGHT              ", _
		"WS_EX_RIGHTSCROLLBAR     ", _
		"WS_EX_RTLREADING         ", _
		"WS_EX_STATICEDGE         ", _
		"WS_EX_TOOLWINDOW         ", _
		"WS_EX_TOPMOST            ", _
		"WS_EX_TRANSPARENT        ", _
		"WS_EX_WINDOWEDGE         ", _
		"GUI_WS_EX_PARENTDRAG     "]

Local Const $upBound = UBound($allStyles)

Global $styles = GUIGetStyle($form)

For $i = 0 To $upBound - 1
	If BitAND($styles[1], $allStyles[$i]) = $allStyles[$i] Then
		ConsoleWrite($names[$i] & " True" & @CRLF)
	Else
		ConsoleWrite($names[$i] & " False" & @CRLF)
	EndIf
Next

Do
	If GUIGetMsg() = $GUI_EVENT_CLOSE Then
		Exit
	EndIf
Until False
