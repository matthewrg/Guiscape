
#AutoIt3Wrapper_Add_Constants=n

#Region - Main Form View

#include-once

#include <ColorConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsStylesConstants.au3>

Func MainForm_View()
	Local $this = _AutoitObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "MainForm_View_Handler")

	_AutoItObject_AddMethod($this, "Create", "MainForm_View_Create")
	_AutoItObject_AddMethod($this, "Show", "MainForm_View_Show")
	_AutoItObject_AddMethod($this, "SetFont", "MainForm_View_SetFont")
	_AutoItObject_AddMethod($this, "SetFontSize", "MainForm_View_SetFontSize")
	_AutoItObject_AddMethod($this, "SetSizePos", "MainForm_View_SetSizePos")

	Local Const $width = 815
	Local Const $height = 860

	_AutoItObject_AddProperty($this, "Hwnd", $ELSCOPE_READONLY, HWnd(Null))
	_AutoItObject_AddProperty($this, "Width", $ELSCOPE_READONLY, $width)
	_AutoItObject_AddProperty($this, "Height", $ELSCOPE_READONLY, $height)
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_READONLY, (@DesktopWidth / 2) - ($width / 2))
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_READONLY, (@DesktopHeight / 2) - ($height / 2))
	_AutoItObject_AddProperty($this, "FontName", $ELSCOPE_READONLY, "Segoe UI")
	_AutoItObject_AddProperty($this, "FontSize", $ELSCOPE_READONLY, 10 * $DPIRatio)

	Return $this
EndFunc   ;==>MainForm_View

Func MainForm_View_Create(ByRef $this)
	$this.Hwnd = GUICreate( _
			"Guiscape", _
			$this.Width * $DPIRatio, _
			$this.Height * $DPIRatio, _
			$this.Left * $DPIRatio, _
			$this.Top * $DPIRatio, _
			BitOR($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX, $WS_SYSMENU))

	Local Const $fontName = $this.FontName

	$this.SetFont($fontName)
EndFunc   ;==>MainForm_View_Create

Func MainForm_View_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>MainForm_View_Show

Func MainForm_View_SetFont(ByRef $this, Const ByRef $fontName)
	$this.FontName = $fontName

	GUISetFont($this.FontSize, -1, -1, $fontName, HWnd($this.Hwnd))
EndFunc   ;==>MainForm_View_SetFont

Func MainForm_View_SetFontSize(ByRef $this, Const ByRef $fontSize)
	$this.FontSize = $fontSize

	GUISetFont($fontSize * $DPIRatio, -1, -1, $this.FontName, HWnd($this.Hwnd))
EndFunc   ;==>MainForm_View_SetFontSize

Func MainForm_View_SetSizePos(ByRef $this)
	Local Const $sizePos = WinGetPos(HWnd($this.Hwnd))

	$this.Left = $sizePos[0] * $DPIRatio
	$this.Top = $sizePos[1] * $DPIRatio
	$this.Width = ($sizePos[2] - 16) * $DPIRatio
	$this.Height = ($sizePos[3] - 39) * $DPIRatio
EndFunc   ;==>MainForm_View_SetSizePos

Func MainForm_View_CreateImbeddedWindow(Const ByRef $this, Const ByRef $title)
	Local Const $hwnd = GUICreate( _
			$title, _
			($this.Width - 100) * $DPIRatio, _
			($this.Height - 60) * $DPIRatio, _
			(90 * $DPIRatio), _
			(30 * $DPIRatio), _
			$WS_CHILD, _
			$WS_EX_OVERLAPPEDWINDOW, _
			HWnd($this.Hwnd))

	GUISetBkColor($COLOR_WHITE, $hwnd)

	GUISetState(@SW_HIDE, $hwnd)

	Return $hwnd
EndFunc   ;==>MainForm_View_CreateImbeddedWindow

#EndRegion - Main Form View
