
#include-once

#include "Form Properties.au3"
#include "Form Styles.au3"
#include "Form Extended Styles.au3"
#include "Form Menu.au3"
#include "Form Context Menu.au3"
#include "Form Accelerators.au3"

Func FormParameters()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "FormParameters_Create")
	$this.AddMethod("Show", "FormParameters_Show")
	$this.AddMethod("Hide", "FormParameters_Hide")
	
	$this.AddProperty("Hwnd", $ELSCOPE_READONLY, $hwnd)

	$this.AddProperty("Properties", $ELSCOPE_READONLY, FormProperties())
	$this.AddProperty("Styles", $ELSCOPE_READONLY, FormStyles())
	$this.AddProperty("ExStyles", $ELSCOPE_READONLY, FormExStyles())
	$this.AddProperty("Menu", $ELSCOPE_READONLY, FormMenu())
	$this.AddProperty("ContextMenu", $ELSCOPE_READONLY, FormContextMenu())
	$this.AddProperty("Accelerators", $ELSCOPE_READONLY, FormAccelerators())

	Return $this.Object
EndFunc   ;==>FormParameters

Func FormParameters_Create(ByRef $this, Const ByRef $parent)

	GUICtrlCreateTab(5 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, ($width - 110) * $g_iDPI_ratio1, ($height - 70) * $g_iDPI_ratio1)
	
	$this.Properties.Show()	

	$this.ExStyles = GUICtrlCreateTabItem("Extended Styles")

	GUICtrlCreateTabItem('')

	$this.Menu = GUICtrlCreateTabItem("Menubar")

	GUICtrlCreateTabItem('')

	$this.ContextMenu = GUICtrlCreateTabItem("Context Menu")

	GUICtrlCreateTabItem('')

	$this.Accelerators = GUICtrlCreateTabItem("Accelerators")

	GUICtrlCreateTabItem('')
EndFunc   ;==>FormParameters_Create

Func FormParameters_Show(ByRef $this, Const ByRef $form)
	GUISetState(@SW_SHOW, HWnd($this.Hwnd))
EndFunc   ;==>FormParameters_Show

Func FormParameters_Hide(ByRef $this)
	GUISetState(@SW_HIDE, HWnd($this.Hwnd))
EndFunc   ;==>FormParameters_Hide
