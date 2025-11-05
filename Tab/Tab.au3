#include-once

#include <GuiConstantsEx.au3>

#include "..\AutoItObject.au3"

Func Tab()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Tab_Create")
	$this.AddMethod("Handler", "Tab_Handler")

	$this.AddProperty("Tab", $ELSCOPE_PRIVATE)

	Return $this.Object
EndFunc   ;==>Tab

Func Tab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab(92 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 390 * $g_iDPI_ratio1, 24 * $g_iDPI_ratio1)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	GUICtrlCreateTabItem("Canvas")

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Properties")

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Script")

	GUICtrlCreateTabItem('')

	GUICtrlCreateTabItem("Object Explorer")

	GUICtrlCreateTabItem('')
EndFunc   ;==>Tab_Create

Func Tab_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Local Const $tabIndex = GUICtrlRead($this.Tab)

			Switch $tabIndex
				Case 0
					Return "Canvas"

				Case 1
					Return "Properties"

				Case 2
					Return "Script"

				Case 3
					Return "Object Explorer"
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>Tab_Handler
