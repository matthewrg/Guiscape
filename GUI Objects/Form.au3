#include-once

#include "Control.au3"

#Region ; form

Func Form(Const $parent, Const $title, Const $left = 5, Const $top = 5, Const $width = 400, Const $height = 600)
	Local Const $hwnd = GUICreate( _
			$title, _
			$width * $DPIRatio, _
			$height * $DPIRatio, _
			$left * $DPIRatio, _
			$top * $DPIRatio, _
			BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), _
			 -1, _
			HWnd($parent))

	Local Const $formContextMenu = GUICtrlCreateContextMenu()

	Local Const $childForm = GUICtrlCreateMenuItem("Child Form", $formContextMenu)
	Local Const $parameters = GUICtrlCreateMenuItem("Parameters", $formContextMenu)
	Local Const $styles = GUICtrlCreateMenuItem("Styles", $formContextMenu)
	Local Const $exStyles = GUICtrlCreateMenuItem("Extended Styles", $formContextMenu)
	Local Const $contextMenu = GUICtrlCreateMenuItem("Context Menu", $formContextMenu)
	Local Const $menubar = GUICtrlCreateMenuItem("Menubar", $formContextMenu)

	Local Const $formStyles = GUIGetStyle($hwnd)

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Form_Handler")
	$this.AddMethod("Show", "Form_Show")
	$this.AddMethod("Hide", "Form_Hide")
	$this.AddMethod("Delete", "Form_Delete")
	$this.AddMethod("GetProperties", "Form_GetProperties")
	$this.AddMethod("GetStyles", "Form_GetStyles")
	$this.AddMethod("GetExStyles", "Form_GetExStyles")

	$this.AddMethod("GetHwnd", "Form_GetHwnd")
	$this.AddMethod("GetTitle", "Form_GetTitle")
	$this.AddMethod("GetLeft", "Form_GetLeft")
	$this.AddMethod("GetTop", "Form_GetTop")
	$this.AddMethod("GetWidth", "Form_GetWidth")
	$this.AddMethod("GetHeight", "Form_GetHeight")
	$this.AddMethod("GetFormBgColor", "Form_GetFormBgColor")
	$this.AddMethod("GetCtrlBgColor", "Form_GetCtrlBgColor")
	$this.AddMethod("GetCtrlFgColor", "Form_GetCtrlFgColor")
	$this.AddMethod("GetCursor", "Form_GetCursor")
	$this.AddMethod("GetFont", "Form_GetFont")
	$this.AddMethod("GetHelpfile", "Form_GetHelpfile")
	$this.AddMethod("GetState", "Form_GetState")
	$this.AddMethod("GetStyle", "Form_GetStyle")
	$this.AddMethod("GetExStyle", "Form_GetExStyle")

	$this.AddMethod("SetTitle", "Form_SetTitle")
	$this.AddMethod("SetName", "Form_SetName")
	$this.AddMethod("SetWidth", "Form_SetWidth")
	$this.AddMethod("SetHeight", "Form_SetHeight")
	$this.AddMethod("SetBgColor", "Form_SetBgColor")
	$this.AddMethod("SetDefBgColor", "Form_SetDefBgColor")
	$this.AddMethod("SetDefFgColor", "Form_SetDefFgColor")
	$this.AddMethod("SetCursor", "Form_SetCursor")
	$this.AddMethod("SetFont", "Form_SetFont")
	$this.AddMethod("SetHelpfile", "Form_SetHelpfile")
	$this.AddMethod("SetState", "Form_SetState")
	$this.AddMethod("SetStyle", "Form_SetStyle")
	$this.AddMethod("SetExStyle", "Form_SetExStyle")

	$this.AddProperty("ChildForm", $ELSCOPE_READONLY, $childForm)
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, $parameters)
	$this.AddProperty("Styles", $ELSCOPE_READONLY, $styles)
	$this.AddProperty("ExStyles", $ELSCOPE_READONLY, $exStyles)
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY, $contextMenu)
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, $menubar)

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE, $hwnd)
	$this.AddProperty("Title", $ELSCOPE_PRIVATE, $title)
	$this.AddProperty("Name", $ELSCOPE_PRIVATE, StringStripWS($title, $STR_STRIPALL))
	$this.AddProperty("Left", $ELSCOPE_PRIVATE, $left)
	$this.AddProperty("Top", $ELSCOPE_PRIVATE, $top)
	$this.AddProperty("Width", $ELSCOPE_PRIVATE, $width)
	$this.AddProperty("Height", $ELSCOPE_PRIVATE, $height)
	$this.AddProperty("FormBgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("DefBgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("DefFgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("Cursor", $ELSCOPE_PRIVATE, "ARROW")
	$this.AddProperty("Font", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Helpfile", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Style", $ELSCOPE_PRIVATE, $formStyles[0])
	$this.AddProperty("ExStyle", $ELSCOPE_PRIVATE, $formStyles[1])

	Return $this.Object
EndFunc   ;==>Form

Func Form_Handler(ByRef $this, Const ByRef $event)
;~ 	If Not $event.Form <> HWnd($this.Hwnd) Then Return False

;~ 	Print($event.Form & " -- " & HWnd($this.Hwnd) & @CRLF)

	Switch $event.ID
		Case $this.ChildForm
			Return "Child Form"

		Case $this.Parameters
			Return "Parameters"

		Case $this.Styles
			Return "Styles"

		Case $this.ExStyles
			Return "Extended Styles"

		Case $this.ContextMenu
			Return "Context Menu"

		Case $this.Menubar
			Return "Menubar"

		Case $GUI_EVENT_PRIMARYUP
;~ 			Print("Clicked on: " & $this.Title)
			Return "Primary Up"

		Case $GUI_EVENT_RESIZED
;~ 			Print("Form Resized: " & $this.Title)
			Return "Form Resized"
	EndSwitch

	Return False
EndFunc   ;==>Form_Handler

Func Form_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>Form_Show

Func Form_Hide(Const ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>Form_Hide

Func Form_Delete(Const ByRef $this)
	GUIDelete(($this.Hwnd))
EndFunc   ;==>Form_Delete

Func Form_GetProperties(ByRef $this)
	Local $properties[]

	$properties.Title = $this.Title
	$properties.Name = $this.Name
	$properties.Left = $this.Left
	$properties.Top = $this.Top
	$properties.Width = $this.Width
	$properties.Height = $this.Height
	$properties.FormBgColor = $this.FormBgColor
	$properties.DefBgColor = $this.DefBgColor
	$properties.DefFgColor = $this.DefFgColor
	$properties.Cursor = $this.Cursor
	$properties.Font = $this.Font
	$properties.Helpfile = $this.Helpfile

	Return $properties
EndFunc   ;==>Form_GetProperties

Func Form_GetStyles(ByRef $this)
	Local $styles[]

	$styles.Style = $this.Style

	Return $styles
EndFunc   ;==>Form_GetStyles

Func Form_GetExStyles(ByRef $this)
	Local $exStyles[]

	$exStyles.ExStyle = $this.ExStyle

	Return $exStyles
EndFunc   ;==>Form_GetExStyles

Func Form_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetStyle

Func Form_GetHwnd(Const ByRef $this)
	Return $this.Hwnd
EndFunc   ;==>Form_GetHwnd

Func Form_GetTitle(Const ByRef $this)
	Return WinGetTitle(HWnd($this.Hwnd))
EndFunc   ;==>Form_GetTitle

Func Form_SetTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Hwnd), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>Form_SetTitle

Func Form_SetName(ByRef $this, Const $name)
	$this.Name = $name

	Return True
EndFunc   ;==>Form_SetName

Func Form_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[0]
EndFunc   ;==>Form_GetLeft

Func Form_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetTop

Func Form_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[2]
EndFunc   ;==>Form_GetWidth

Func Form_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[3]
EndFunc   ;==>Form_GetHeight

Func Form_GetExStyle(ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[1]
EndFunc   ;==>Form_GetExStyle

Func Form_SetWidth(ByRef $this, Const $width)
	$this.Width = $width

	Return WinMove(HWnd($this.Hwnd), Default, Default, $width * $DPIRatio)
EndFunc   ;==>Form_SetWidth

Func Form_SetHeight(ByRef $this, Const ByRef $height)
	$this.Height = $height

	Return WinMove(HWnd($this.Hwnd), Default, Default, Default, $height * $DPIRatio)
EndFunc   ;==>Form_SetHeight

Func Form_SetBGColor(ByRef $this, Const ByRef $bgColor)
	$this.BGColor = $bgColor

	GUISetBkColor($bgColor, HWnd($this.Hwnd))
EndFunc   ;==>FormSetBGColor
