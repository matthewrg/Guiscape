#include-once
#include <WindowsStylesConstants.au3>

#include "..\..\AutoItObject.au3"

Func FormObject(Const $parent)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "FormObject_Handler")
	$this.AddMethod("Create", "FormObject_Create")
	$this.AddMethod("CreateButton", "FormObject_CreateButton")
	$this.AddMethod("Show", "FormObject_Show")
	$this.AddMethod("ChangeTitle", "FormObject_ChangeTitle")
	$this.AddMethod("GetLeft", "FormObject_GetLeft")
	$this.AddMethod("GetTop", "FormObject_GetTop")
	$this.AddMethod("GetWidth", "FormObject_GetWidth")
	$this.AddMethod("GetHeight", "FormObject_GetHeight")
	$this.AddMethod("GetStyle", "FormObject_GetStyle")
	$this.AddMethod("GetExStyle", "FormObject_GetExStyle")

	$this.AddProperty("Parent", $ELSCOPE_READONLY, $parent)
	$this.AddProperty("Form", $ELSCOPE_READONLY)
	$this.AddProperty("Title", $ELSCOPE_READONLY)
	$this.AddProperty("Name", $ELSCOPE_READONLY)
	$this.AddProperty("Left", $ELSCOPE_READONLY)
	$this.AddProperty("Top", $ELSCOPE_READONLY)
	$this.AddProperty("Width", $ELSCOPE_READONLY)
	$this.AddProperty("Height", $ELSCOPE_READONLY)
	$this.AddProperty("Style", $ELSCOPE_READONLY)
	$this.AddProperty("ExStyle", $ELSCOPE_READONLY)

	$this.AddProperty("ButtonID", $ELSCOPE_READONLY)

	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, $parent)

	Return $this.Object
EndFunc   ;==>FormObject

Func FormObject_Handler(ByRef $this, Const ByRef $event)
	If Not $event.FormHwnd <> $this.View.Hwnd Then Return False

	Return False
EndFunc   ;==>FormObject_Handler

Func FormObject_Create(ByRef $this)
	$this.Form = GUICreate("EVIL!", 400, 600, 5, 5, BitOR($WS_CHILD, $WS_OVERLAPPEDWINDOW), -1, HWnd($this.Parent))

	Local Const $contextMenu = GUICtrlCreateContextMenu()

	GUICtrlCreateMenuItem("Child Form", $contextMenu)

	GUICtrlCreateMenuItem("Properties", $contextMenu)

	GUICtrlCreateMenuItem("Script", $contextMenu)

	$this.Ttitle = WinGetTitle(HWnd($this.Form))

	Local Const $pos = WinGetPos(HWnd($this.Form))

	$this.Left = $pos[0]
	$this.Top = $pos[1]
	$this.Width = $pos[2]
	$this.Height = $pos[3]

	Local Const $styles = GUIGetStyle(HWnd($this.Form))

	$this.Style = $styles[0]
	$this.ExStyle = $styles[1]

	GUISetState(@SW_SHOWNORMAL, HWnd($this.Form))

	Return True
EndFunc   ;==>FormObject_Create

Func FormObject_Show(Const ByRef $this)
	GUISetState(@SW_SHOWNORMAL, HWnd($this.Form))
EndFunc   ;==>FormObject_Show

Func FormObject_GetStyle(Const ByRef $this)
	Return GUIGetStyle(HWnd($this.Form))[0]
EndFunc   ;==>FormObject_GetStyle

Func FormObject_ChangeTitle(ByRef $this, Const $newTitle)
	WinSetTitle(HWnd($this.Form), '', $newTitle)

	$this.Title = $newTitle
EndFunc   ;==>FormObject_ChangeTitle

Func FormObject_GetLeft(Const ByRef $this)
	Return WinGetPos(HWnd($this.Form))[0]
EndFunc   ;==>FormObject_GetLeft

Func FormObject_GetTop(Const ByRef $this)
	Return WinGetPos(HWnd($this.Form))[1]
EndFunc   ;==>FormObject_GetTop

Func FormObject_GetWidth(Const ByRef $this)
	Return WinGetPos(HWnd($this.Form))[2]
EndFunc   ;==>FormObject_GetWidth

Func FormObject_GetHeight(Const ByRef $this)
	Return WinGetPos(HWnd($this.Form))[3]
EndFunc   ;==>FormObject_GetHeight

Func FormObject_GetExStyle(ByRef $this)
	Return GUIGetStyle(HWnd($this.Form))[1]
EndFunc   ;==>FormObject_GetExStyle

Func FormObject_CreateButton(ByRef $this)
	Local Const $prev = GUISwitch(HWnd($this.Form))

	$this.ButtonID = GUICtrlCreateButton("Click Me! }:)", 10, 10)

	GUISwitch($prev)
EndFunc   ;==>FormObject_CreateButton
