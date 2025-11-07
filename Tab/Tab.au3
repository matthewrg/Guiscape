#include-once

#include <GuiConstantsEx.au3>

#include "..\AutoItObject.au3"

Func Tab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Tab_Create")
	$this.AddMethod("Handler", "Tab_Handler")

	$this.AddProperty("Canvas", $ELSCOPE_READONLY)
	$this.AddProperty("Properties", $ELSCOPE_READONLY)
	$this.AddProperty("Script", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY)
	
	$this.AddProperty("Tab", $ELSCOPE_PRIVATE)

	Return $this.Object
EndFunc   ;==>Tab

Func Tab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab(92 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 390 * $g_iDPI_ratio1, 24 * $g_iDPI_ratio1)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.Canvas = GUICtrlCreateTabItem("Canvas")

	GUICtrlCreateTabItem('')

	$this.Properties = GUICtrlCreateTabItem("Properties")

	GUICtrlCreateTabItem('')

	$this.Script = GUICtrlCreateTabItem("Script")

	GUICtrlCreateTabItem('')

	$this.ObjectExplorer = GUICtrlCreateTabItem("Object Explorer")

	GUICtrlCreateTabItem('')
EndFunc   ;==>Tab_Create

Func Tab_Handler(Const ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Return GUICtrlRead($this.Tab, $GUI_READ_EXTENDED)
	EndSwitch

	Return False
EndFunc   ;==>Tab_Handler
