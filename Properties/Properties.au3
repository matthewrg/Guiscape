#include-once

#include "..\AutoItObject.au3"

#include "Form Styles.au3"

#include "Form ExStyles.au3"

Func Properties()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Properties_Create")
	$this.AddMethod("Show", "Properties_Show")
	$this.AddMethod("Hide", "Properties_Hide")
	
	$this.AddProperty("FormStyles", $ELSCOPE_READONLY, FormStyles())
	$this.AddProperty("FormExStyles", $ELSCOPE_READONLY, FormExStyles())

	$this.AddProperty("Hwnd", $ELSCOPE_PRIVATE)

	Return $this.Object
EndFunc   ;==>Properties

Func Properties_Create(ByRef $this, Const $parent)
	$this.Hwnd = GUICreate("Properties", ($parent.Width - 100), ($parent.Height - 60), 90, 30, $WS_CHILD, $WS_EX_OVERLAPPEDWINDOW, HWnd($parent.Hwnd))

	GUICtrlCreateTab(0, 0, ($parent.Width - 100), ($parent.Height - 60))

	GUICtrlCreateTabItem("Properties")

	GUICtrlCreateTabItem('')

	$this.FormStyles.Create()

	$this.FormExStyles.Create()
EndFunc   ;==>Properties_Create

Func Properties_Show(ByRef $this)
	GUISetState(@SW_SHOW, $this.Hwnd)
EndFunc   ;==>Properties_Show

Func Properties_Hide(ByRef $this)
	GUISetState(@SW_HIDE, $this.Hwnd)
EndFunc   ;==>Properties_Hide
