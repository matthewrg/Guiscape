#include-once

#include <WindowsStylesConstants.au3>

#include "..\..\AutoItObject.au3"

Func GUIObject(Const $parent)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "GUIObject_Handler")
	$this.AddMethod("Create", "GUIObject_Create")

	$this.AddMethod("GetTitle", "GUIObject_GetTitle")
	$this.AddMethod("GetLeft", "GUIObject_GetLeft")
	$this.AddMethod("GetTop", "GUIObject_GetTop")
	$this.AddMethod("GetWidth", "GUIObject_GetWidth")
	$this.AddMethod("GetHeight", "GUIObject_GetHeight")
	$this.AddMethod("GetFormBgColor", "GUIObject_GetFormBgColor")
	$this.AddMethod("GetCtrlBgColor", "GUIObject_GetCtrlBgColor")
	$this.AddMethod("GetCtrlFgColor", "GUIObject_GetCtrlFgColor")
	$this.AddMethod("GetCursor", "GUIObject_GetCursor")
	$this.AddMethod("GetFont", "GUIObject_GetFont")
	$this.AddMethod("GetHelpfile", "GUIObject_GetHelpfile")
	$this.AddMethod("GetState", "GUIObject_GetState")
	$this.AddMethod("GetStyle", "GUIObject_GetStyle")
	$this.AddMethod("GetExStyle", "GUIObject_GetExStyle")

	$this.AddMethod("Show", "GUIObject_Show")
	$this.AddMethod("Hide", "GUIObject_Hide")
	$this.AddMethod("SetTitle", "GUIObject_SetTitle")
	$this.AddMethod("SetName", "GUIObject_SetName")
	$this.AddMethod("SetWidth", "GUIObject_SetWidth")
	$this.AddMethod("SetHeight", "GUIObject_SetHeight")
	$this.AddMethod("SetFormBgColor", "GUIObject_SetFormBgColor")
	$this.AddMethod("SetCtrlBgColor", "GUIObject_SetCtrlBgColor")
	$this.AddMethod("SetCtrlFgColor", "GUIObject_SetCtrlFgColor")
	$this.AddMethod("SetCursor", "GUIObject_SetCursor")
	$this.AddMethod("SetFont", "GUIObject_SetFont")
	$this.AddMethod("SetHelpfile", "GUIObject_SetHelpfile")
	$this.AddMethod("SetState", "GUIObject_SetState")
	$this.AddMethod("SetStyle", "GUIObject_SetStyle")
	$this.AddMethod("SetExStyle", "GUIObject_SetExStyle")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	
	$this.AddProperty("ChildForm", $ELSCOPE_READONLY)
	$this.AddProperty("Properties", $ELSCOPE_READONLY)
	$this.AddProperty("Styles", $ELSCOPE_READONLY)
	$this.AddProperty("ExStyles", $ELSCOPE_READONLY)
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY)
	$this.AddProperty("Menubar", $ELSCOPE_READONLY)

	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, HWnd($parent))
	$this.AddProperty("Title", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Name", $ELSCOPE_PRIVATE, '')
	$this.AddProperty("Left", $ELSCOPE_PRIVATE)
	$this.AddProperty("Top", $ELSCOPE_PRIVATE)
	$this.AddProperty("Width", $ELSCOPE_PRIVATE)
	$this.AddProperty("Height", $ELSCOPE_PRIVATE)
	$this.AddProperty("FormBgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("CtrlBgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("CtrlFgColor", $ELSCOPE_PRIVATE)
	$this.AddProperty("Cursor", $ELSCOPE_PRIVATE)
	$this.AddProperty("Font", $ELSCOPE_PRIVATE)
	$this.AddProperty("Helpfile", $ELSCOPE_PRIVATE)
	$this.AddProperty("State", $ELSCOPE_PRIVATE)
	$this.AddProperty("Style", $ELSCOPE_PRIVATE)
	$this.AddProperty("ExStyle", $ELSCOPE_PRIVATE)

	; To-Do: Move this into a seperate button object
	$this.AddMethod("CreateButton", "GUIObject_CreateButton")
	$this.AddProperty("ButtonID", $ELSCOPE_READONLY)

	Return $this.Object
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

Func GUIObject_Create(ByRef $this)
	$this.Hwnd = GUICreate('', 400 * $g_iDPI_ratio1, 600 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), -1, HWnd($this.Parent))
		
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

Func GUIObject_CreateButton(ByRef $this)
	Local Const $prev = GUISwitch(HWnd($this.Hwnd))

	$this.ButtonID = GUICtrlCreateButton("<new button>", 10, 10)

	GUISwitch($prev)
EndFunc   ;==>GUIObject_CreateButton
