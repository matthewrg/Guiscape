#include-once

#include <GuiConstantsEx.au3>
#include <WindowsStylesConstants.au3>

#include "..\AutoItObject.au3"

Func FormExStyles()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "FormExStyles_Create")
	$this.AddMethod("Handler", "FormExStyles_Handler")
	$this.AddMethod("Initialize", "FormExStyles_Initialize")

	$this.AddProperty("WS_EX_ACCEPTFILES", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_APPWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CLIENTEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_COMPOSITED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTEXTHELP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_CONTROLPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_DLGMODALFRAME", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYERED", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LAYOUTRTL", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LEFTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_LTRREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_MDICHILD", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOACTIVATE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOINHERITLAYOUT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOPARENTNOTIFY", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_NOREDIRECTIONBITMAP", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_OVERLAPPEDWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_PALETTEWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RIGHTSCROLLBAR", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_RTLREADING", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_STATICEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOOLWINDOW", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TOPMOST", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_TRANSPARENT", $ELSCOPE_READONLY)
	$this.AddProperty("WS_EX_WINDOWEDGE", $ELSCOPE_READONLY)
	$this.AddProperty("GUI_WS_EX_PARENTDRAG", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>FormExStyles

Func FormExStyles_Handler(ByRef $this, Const $eventID)
	#forceref $this, $eventID

EndFunc   ;==>FormExStyles_Handler

Func FormExStyles_Create(ByRef $this)
	GUICtrlCreateTabItem("Extended Styles")

	$this.WS_EX_ACCEPTFILES = GUICtrlCreateCheckbox("WS_EX_ACCEPTFILES", 10 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1)
	$this.WS_EX_APPWINDOW = GUICtrlCreateCheckbox("WS_EX_APPWINDOW", 10 * $g_iDPI_ratio1, 50 * $g_iDPI_ratio1)
	$this.WS_EX_CLIENTEDGE = GUICtrlCreateCheckbox("WS_EX_CLIENTEDGE", 10 * $g_iDPI_ratio1, 70 * $g_iDPI_ratio1)
	$this.WS_EX_COMPOSITED = GUICtrlCreateCheckbox("WS_EX_COMPOSITED", 10 * $g_iDPI_ratio1, 90 * $g_iDPI_ratio1)
	$this.WS_EX_CONTEXTHELP = GUICtrlCreateCheckbox("WS_EX_CONTEXTHELP", 10 * $g_iDPI_ratio1, 110 * $g_iDPI_ratio1)
	$this.WS_EX_CONTROLPARENT = GUICtrlCreateCheckbox("WS_EX_CONTROLPARENT", 10 * $g_iDPI_ratio1, 130 * $g_iDPI_ratio1)
	$this.WS_EX_DLGMODALFRAME = GUICtrlCreateCheckbox("WS_EX_DLGMODALFRAME", 10 * $g_iDPI_ratio1, 150 * $g_iDPI_ratio1)
	$this.WS_EX_LAYERED = GUICtrlCreateCheckbox("WS_EX_LAYERED", 10 * $g_iDPI_ratio1, 170 * $g_iDPI_ratio1)
	$this.WS_EX_LAYOUTRTL = GUICtrlCreateCheckbox("WS_EX_LAYOUTRTL", 10 * $g_iDPI_ratio1, 190 * $g_iDPI_ratio1)
	$this.WS_EX_LEFT = GUICtrlCreateCheckbox("WS_EX_LEFT", 10 * $g_iDPI_ratio1, 210 * $g_iDPI_ratio1)
	$this.WS_EX_LEFTSCROLLBAR = GUICtrlCreateCheckbox("WS_EX_LEFTSCROLLBAR", 10 * $g_iDPI_ratio1, 230 * $g_iDPI_ratio1)
	$this.WS_EX_LTRREADING = GUICtrlCreateCheckbox("WS_EX_LTRREADING", 10 * $g_iDPI_ratio1, 250 * $g_iDPI_ratio1)
	$this.WS_EX_MDICHILD = GUICtrlCreateCheckbox("WS_EX_MDICHILD", 10 * $g_iDPI_ratio1, 270 * $g_iDPI_ratio1)
	$this.WS_EX_NOACTIVATE = GUICtrlCreateCheckbox("WS_EX_NOACTIVATE", 10 * $g_iDPI_ratio1, 290 * $g_iDPI_ratio1)
	$this.WS_EX_NOINHERITLAYOUT = GUICtrlCreateCheckbox("WS_EX_NOINHERITLAYOUT", 10 * $g_iDPI_ratio1, 310 * $g_iDPI_ratio1)
	$this.WS_EX_NOPARENTNOTIFY = GUICtrlCreateCheckbox("WS_EX_NOPARENTNOTIFY", 10 * $g_iDPI_ratio1, 330 * $g_iDPI_ratio1)
	$this.WS_EX_NOREDIRECTIONBITMAP = GUICtrlCreateCheckbox("WS_EX_NOREDIRECTIONBITMAP", 10 * $g_iDPI_ratio1, 350 * $g_iDPI_ratio1)
	$this.WS_EX_OVERLAPPEDWINDOW = GUICtrlCreateCheckbox("WS_EX_OVERLAPPEDWINDOW", 10 * $g_iDPI_ratio1, 370 * $g_iDPI_ratio1)
	$this.WS_EX_PALETTEWINDOW = GUICtrlCreateCheckbox("WS_EX_PALETTEWINDOW", 10 * $g_iDPI_ratio1, 390 * $g_iDPI_ratio1)
	$this.WS_EX_EX_RIGHT = GUICtrlCreateCheckbox("WS_EX_RIGHT", 10 * $g_iDPI_ratio1, 410 * $g_iDPI_ratio1)
	$this.WS_EX_RIGHTSCROLLBAR = GUICtrlCreateCheckbox("WS_EX_RIGHTSCROLLBAR", 10 * $g_iDPI_ratio1, 430 * $g_iDPI_ratio1)
	$this.WS_EX_RTLREADING = GUICtrlCreateCheckbox("WS_EX_RTLREADING", 10 * $g_iDPI_ratio1, 450 * $g_iDPI_ratio1)
	$this.WS_EX_STATICEDGE = GUICtrlCreateCheckbox("WS_EX_STATICEDGE", 10 * $g_iDPI_ratio1, 470 * $g_iDPI_ratio1)
	$this.WS_EX_TOOLWINDOW = GUICtrlCreateCheckbox("WS_EX_TOOLWINDOW", 10 * $g_iDPI_ratio1, 490 * $g_iDPI_ratio1)
	$this.WS_EX_TOPMOST = GUICtrlCreateCheckbox("WS_EX_TOPMOST", 10 * $g_iDPI_ratio1, 510 * $g_iDPI_ratio1)
	$this.WS_EX_TRANSPARENT = GUICtrlCreateCheckbox("WS_EX_TRANSPARENT", 10 * $g_iDPI_ratio1, 530 * $g_iDPI_ratio1)
	$this.WS_EX_WINDOWEDGE = GUICtrlCreateCheckbox("WS_EX_WINDOWEDGE", 10 * $g_iDPI_ratio1, 550 * $g_iDPI_ratio1)
	$this.GUI_WS_EX_PARENTDRAG = GUICtrlCreateCheckbox("GUI_WS_EX_PARENTDRAG", 10 * $g_iDPI_ratio1, 570 * $g_iDPI_ratio1)

	GUICtrlCreateTabItem('')
EndFunc   ;==>FormExStyles_Create

Func FormExStyles_Initialize(ByRef $this, Const $exStyles)
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

	Local Const $vars[] = [$this.WS_EX_ACCEPTFILES, _
			$this.WS_EX_APPWINDOW, _
			$this.WS_EX_CLIENTEDGE, _
			$this.WS_EX_COMPOSITED, _
			$this.WS_EX_CONTEXTHELP, _
			$this.WS_EX_CONTROLPARENT, _
			$this.WS_EX_DLGMODALFRAME, _
			$this.WS_EX_LAYERED, _
			$this.WS_EX_LAYOUTRTL, _
			$this.WS_EX_LEFT, _
			$this.WS_EX_LEFTSCROLLBAR, _
			$this.WS_EX_LTRREADING, _
			$this.WS_EX_MDICHILD, _
			$this.WS_EX_NOACTIVATE, _
			$this.WS_EX_NOINHERITLAYOUT, _
			$this.WS_EX_NOPARENTNOTIFY, _
			$this.WS_EX_NOREDIRECTIONBITMAP, _
			$this.WS_EX_OVERLAPPEDWINDOW, _
			$this.WS_EX_PALETTEWINDOW, _
			$this.WS_EX_RIGHT, _
			$this.WS_EX_RIGHTSCROLLBAR, _
			$this.WS_EX_RTLREADING, _
			$this.WS_EX_STATICEDGE, _
			$this.WS_EX_TOOLWINDOW, _
			$this.WS_EX_TOPMOST, _
			$this.WS_EX_TRANSPARENT, _
			$this.WS_EX_WINDOWEDGE, _
			$this.GUI_WS_EX_PARENTDRAG]

	Local Const $upBound = UBound($allStyles)

	; This loop just makes the windows that Guiscape creates look like a regular window when
	; looking at the Styles tab under the Properties tab. Not sure yet if this will cause 
	; problems down the road!
	For $i = 0 To $upBound - 1
		If BitAND($exStyles, $allStyles[$i]) = $allStyles[$i] Then
			Switch $allStyles[$i]
				Case $WS_EX_OVERLAPPEDWINDOW, $WS_EX_PALETTEWINDOW
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_CHECKED)
			EndSwitch
		Else
			Switch $allStyles[$i]
				Case $WS_EX_LEFT, $WS_EX_LTRREADING, $WS_EX_RIGHTSCROLLBAR
					GUICtrlSetState($vars[$i], $GUI_CHECKED)

				Case Else
					GUICtrlSetState($vars[$i], $GUI_UNCHECKED)
			EndSwitch
		EndIf
	Next
EndFunc   ;==>FormExStyles_Initialize
