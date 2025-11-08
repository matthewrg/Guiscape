#include-once

#include <WindowsStylesConstants.au3>
#include <StringConstants.au3>

#include "..\..\AutoItObject.au3"

Func GUIObject(Const $parent)
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "GUIObject_Handler")
	_AutoItObject_AddMethod($this, "Create", "GUIObject_Create")
	
	_AutoItObject_AddMethod($this, "GetHwnd", "GUIObject_GetHwnd")
	_AutoItObject_AddMethod($this, "GetTitle", "GUIObject_GetTitle")
	_AutoItObject_AddMethod($this, "GetLeft", "GUIObject_GetLeft")
	_AutoItObject_AddMethod($this, "GetTop", "GUIObject_GetTop")
	_AutoItObject_AddMethod($this, "GetWidth", "GUIObject_GetWidth")
	_AutoItObject_AddMethod($this, "GetHeight", "GUIObject_GetHeight")
	_AutoItObject_AddMethod($this, "GetFormBgColor", "GUIObject_GetFormBgColor")
	_AutoItObject_AddMethod($this, "GetCtrlBgColor", "GUIObject_GetCtrlBgColor")
	_AutoItObject_AddMethod($this, "GetCtrlFgColor", "GUIObject_GetCtrlFgColor")
	_AutoItObject_AddMethod($this, "GetCursor", "GUIObject_GetCursor")
	_AutoItObject_AddMethod($this, "GetFont", "GUIObject_GetFont")
	_AutoItObject_AddMethod($this, "GetHelpfile", "GUIObject_GetHelpfile")
	_AutoItObject_AddMethod($this, "GetState", "GUIObject_GetState")
	_AutoItObject_AddMethod($this, "GetStyle", "GUIObject_GetStyle")
	_AutoItObject_AddMethod($this, "GetExStyle", "GUIObject_GetExStyle")
	
	_AutoItObject_AddMethod($this, "Show", "GUIObject_Show")
	_AutoItObject_AddMethod($this, "Hide", "GUIObject_Hide")
	_AutoItObject_AddMethod($this, "SetTitle", "GUIObject_SetTitle")
	_AutoItObject_AddMethod($this, "SetName", "GUIObject_SetName")
	_AutoItObject_AddMethod($this, "SetWidth", "GUIObject_SetWidth")
	_AutoItObject_AddMethod($this, "SetHeight", "GUIObject_SetHeight")
	_AutoItObject_AddMethod($this, "SetFormBgColor", "GUIObject_SetFormBgColor")
	_AutoItObject_AddMethod($this, "SetCtrlBgColor", "GUIObject_SetCtrlBgColor")
	_AutoItObject_AddMethod($this, "SetCtrlFgColor", "GUIObject_SetCtrlFgColor")
	_AutoItObject_AddMethod($this, "SetCursor", "GUIObject_SetCursor")
	_AutoItObject_AddMethod($this, "SetFont", "GUIObject_SetFont")
	_AutoItObject_AddMethod($this, "SetHelpfile", "GUIObject_SetHelpfile")
	_AutoItObject_AddMethod($this, "SetState", "GUIObject_SetState")
	_AutoItObject_AddMethod($this, "SetStyle", "GUIObject_SetStyle")
	_AutoItObject_AddMethod($this, "SetExStyle", "GUIObject_SetExStyle")
	_AutoItObject_AddMethod($this, "Delete", "GUIObject_Delete")

	_AutoItObject_AddProperty($this, "ChildForm", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Properties", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Styles", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "ExStyles", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "ContextMenu", $ELSCOPE_READONLY)
	_AutoItObject_AddProperty($this, "Menubar", $ELSCOPE_READONLY)
	
	_AutoItObject_AddProperty($this, "Hwnd", $ELSCOPE_PRIVATE, 0)
	_AutoItObject_AddProperty($this, "Parent", $ELSCOPE_PRIVATE, HWnd($parent))
	_AutoItObject_AddProperty($this, "Title", $ELSCOPE_PRIVATE, '')
	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_PRIVATE, '')
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Width", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Height", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "FormBgColor", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "CtrlBgColor", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "CtrlFgColor", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Cursor", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Font", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Helpfile", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "State", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "Style", $ELSCOPE_PRIVATE)
	_AutoItObject_AddProperty($this, "ExStyle", $ELSCOPE_PRIVATE)

	Return $this
EndFunc   ;==>GUIObject

Func GUIObject_Handler(ByRef $this, Const ByRef $event)
	If Not $event.FormHwnd <> HWnd($this.Hwnd) Then Return False

	Switch $event.ID
		Case $this.ChildForm
			Return "Child Form"

		Case $this.Properties
			Return "Properties"

		Case $this.Styles
			Return "Styles"

		Case $this.ExStyles
			Return "Extended Styles"

		Case $this.ContextMenu
			Return "Context Menu"

		Case $this.Menubar
			Return "Menubar"

		Case $GUI_EVENT_RESIZED
			Return "Form Resized"
	EndSwitch

	Return False
EndFunc   ;==>GUIObject_Handler

Func GUIObject_Create(ByRef $this, Const ByRef $title)
	$this.Hwnd = GUICreate($title, 400 * $g_iDPI_ratio1, 600 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), -1, HWnd($this.Parent))
		
	$this.Title = $title
	
	$this.Name = StringStripWS($title, $STR_STRIPALL)
		
	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ChildForm = GUICtrlCreateMenuItem("Child Form", $contextMenu)
	$this.Properties = GUICtrlCreateMenuItem("Properties", $contextMenu)
	$this.Styles = GUICtrlCreateMenuItem("Styles", $contextMenu)
	$this.ExStyles = GUICtrlCreateMenuItem("Extended Styles", $contextMenu)
	$this.ContextMenu = GUICtrlCreateMenuItem("Context Menu", $contextMenu)
	$this.Menubar = GUICtrlCreateMenuItem("Menubar", $contextMenu)

	Local Const $pos = WinGetPos(HWnd($this.Hwnd))

	$this.Left = $pos[0]
	$this.Top = $pos[1]
	$this.Width = $pos[2]
	$this.Height = $pos[3]

	Local Const $styles = GUIGetStyle(HWnd($this.Hwnd))

	$this.Style = $styles[0]
	$this.ExStyle = $styles[1]

	GUISetState(@SW_SHOW, HWnd($this.Hwnd))

	Return True
EndFunc   ;==>GUIObject_Create

Func GUIObject_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>GUIObject_Show

Func GUIObject_Hide(Const ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>GUIObject_Hide

Func GUIObject_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[0]
EndFunc   ;==>GUIObject_GetStyle

Func GUIObject_GetHwnd(Const ByRef $this)
	Return $this.Hwnd
EndFunc

Func GUIObject_GetTitle(Const ByRef $this)
	Return WinGetTitle(HWnd($this.Hwnd))
EndFunc

Func GUIObject_SetTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Hwnd), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>GUIObject_SetTitle

Func GUIObject_SetName(ByRef $this, Const $name)
	$this.Name = $name
	
	Return True
EndFunc

Func GUIObject_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[0]
EndFunc   ;==>GUIObject_GetLeft

Func GUIObject_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[1]
EndFunc   ;==>GUIObject_GetTop

Func GUIObject_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[2]
EndFunc   ;==>GUIObject_GetWidth

Func GUIObject_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[3]
EndFunc   ;==>GUIObject_GetHeight

Func GUIObject_GetExStyle(ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[1]
EndFunc   ;==>GUIObject_GetExStyle

Func GUIObject_SetWidth(ByRef $this, Const $width)
	$this.Width = $width

	Return WinMove(HWnd($this.Hwnd), Default, Default, $width * $g_iDPI_ratio1)
EndFunc   ;==>GUIObject_SetWidth

Func GUIObject_SetHeight(ByRef $this, Const ByRef $height)
	$this.Height = $height

	Return WinMove(HWnd($this.Hwnd), Default, Default, Default, $height * $g_iDPI_ratio1)
EndFunc   ;==>GUIObject_SetHeight

Func GUIObject_Delete(Const ByRef $this)	
	GUIDelete(($this.Hwnd))
EndFunc
