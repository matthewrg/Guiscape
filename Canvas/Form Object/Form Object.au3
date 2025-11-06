#include-once

#include <WindowsStylesConstants.au3>

#include "..\..\AutoItObject.au3"

Func FormObject(Const $parent)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "FormObject_Handler")	
	$this.AddMethod("Create", "FormObject_Create")
	
	$this.AddMethod("GetTitle", "FormObject_GetTitle")
	$this.AddMethod("GetLeft", "FormObject_GetLeft")
	$this.AddMethod("GetTop", "FormObject_GetTop")
	$this.AddMethod("GetWidth", "FormObject_GetWidth")
	$this.AddMethod("GetHeight", "FormObject_GetHeight")
	$this.AddMethod("GetFormBgColor", "FormObject_GetFormBgColor")
	$this.AddMethod("GetCtrlBgColor", "FormObject_GetCtrlBgColor")
	$this.AddMethod("GetCtrlFgColor", "FormObject_GetCtrlFgColor")
	$this.AddMethod("GetCursor", "FormObject_GetCursor")
	$this.AddMethod("GetFont", "FormObject_GetFont")
	$this.AddMethod("GetHelpfile", "FormObject_GetHelpfile")
	$this.AddMethod("GetState", "FormObject_GetState")
	$this.AddMethod("GetStyle", "FormObject_GetStyle")
	$this.AddMethod("GetExStyle", "FormObject_GetExStyle")
	
	$this.AddMethod("Show", "FormObject_Show")
	$this.AddMethod("Hide", "FormObject_Hide")
	$this.AddMethod("SetTitle", "FormObject_SetTitle")
	$this.AddMethod("SetWidth", "FormObject_SetWidth")
	$this.AddMethod("SetHeight", "FormObject_SetHeight")
	$this.AddMethod("SetFormBgColor", "FormObject_SetFormBgColor")
	$this.AddMethod("SetCtrlBgColor", "FormObject_SetCtrlBgColor")
	$this.AddMethod("SetCtrlFgColor", "FormObject_SetCtrlFgColor")
	$this.AddMethod("SetCursor", "FormObject_SetCursor")
	$this.AddMethod("SetFont", "FormObject_SetFont")
	$this.AddMethod("SetHelpfile", "FormObject_SetHelpfile")
	$this.AddMethod("SetState", "FormObject_SetState")
	$this.AddMethod("SetStyle", "FormObject_SetStyle")
	$this.AddMethod("SetExStyle", "FormObject_SetExStyle")

	$this.AddProperty("Hwnd", $ELSCOPE_READONLY)
	$this.AddProperty("ChildForm", $ELSCOPE_READONLY)
	$this.AddProperty("Properties", $ELSCOPE_READONLY)
	$this.AddProperty("Styles", $ELSCOPE_READONLY)
	$this.AddProperty("ExStyles", $ELSCOPE_READONLY)
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY)
	$this.AddProperty("Menubar", $ELSCOPE_READONLY)

	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, $parent)
	$this.AddProperty("Title", $ELSCOPE_PRIVATE)
	$this.AddProperty("Name", $ELSCOPE_PRIVATE)
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
	$this.AddMethod("CreateButton", "FormObject_CreateButton")
	$this.AddProperty("ButtonID", $ELSCOPE_READONLY)

	Return $this.Object
EndFunc   ;==>FormObject

Func FormObject_Handler(ByRef $this, Const ByRef $event)
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
EndFunc   ;==>FormObject_Handler

Func FormObject_Create(ByRef $this, Const $title = "<new form>")
	$this.Hwnd = GUICreate($title, 400 * $g_iDPI_ratio1, 600 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), -1, HWnd($this.Parent))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	$this.ChildForm = GUICtrlCreateMenuItem("Child Form", $contextMenu)

	$this.Properties = GUICtrlCreateMenuItem("Properties", $contextMenu)

	$this.Styles = GUICtrlCreateMenuItem("Styles", $contextMenu)

	$this.ExStyles = GUICtrlCreateMenuItem("Extended Styles", $contextMenu)
	
	$this.ContextMenu = GUICtrlCreateMenuItem("Context Menu", $contextMenu)
	
	$this.Menubar = GUICtrlCreateMenuItem("Menubar", $contextMenu)

	$this.Ttitle = WinGetTitle(HWnd($this.Hwnd))

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
EndFunc   ;==>FormObject_Create

Func FormObject_Show(Const ByRef $this)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>FormObject_Show

Func FormObject_Hide(Const ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>FormObject_Show

Func FormObject_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[0]
EndFunc   ;==>FormObject_GetStyle

Func FormObject_SetTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Hwnd), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>FormObject_SetTitle

Func FormObject_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[0]
EndFunc   ;==>FormObject_GetLeft

Func FormObject_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[1]
EndFunc   ;==>FormObject_GetTop

Func FormObject_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[2]
EndFunc   ;==>FormObject_GetWidth

Func FormObject_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Hwnd))[3]
EndFunc   ;==>FormObject_GetHeight

Func FormObject_GetExStyle(ByRef $this)
	Return GUIGetStyle(HWnd($this.Hwnd))[1]
EndFunc   ;==>FormObject_GetExStyle

Func FormObject_SetWidth(ByRef $this, Const $width)
	$this.Width = $width

	Return WinMove(HWnd($this.Hwnd), Default, Default, $width * $g_iDPI_ratio1)
EndFunc   ;==>FormObject_SetWidth

Func FormObject_SetHeight(ByRef $this, Const ByRef $height)
	$this.Height = $height

	Return WinMove(HWnd($this.Hwnd), Default, Default, Default, $height * $g_iDPI_ratio1)
EndFunc   ;==>FormObject_SetHeight

Func FormObject_CreateButton(ByRef $this)
	Local Const $prev = GUISwitch(HWnd($this.Hwnd))

	$this.ButtonID = GUICtrlCreateButton("<new button>", 10, 10)

	GUISwitch($prev)
EndFunc   ;==>FormObject_CreateButton
