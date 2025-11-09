#include-once

#include "Canvas Tab.au3"
#include "Parameters Tab.au3"
#include "Script Tab.au3"
#include "Object Explorer Tab.au3"

Func MainTab(Const $parent)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "MainTab_Create")
	$this.AddMethod("Handler", "MainTab_Handler")
	$this.AddMethod("ShowCanvas", "MainTab_ShowCanvas")
	$this.AddMethod("ShowParameters", "MainTab_ShowParameters")
	$this.AddMethod("ShowScript", "MainTab_ShowScript")
	$this.AddMethod("ShowObjectExplorer", "MainTab_ShowObjectExplorer")

	$this.AddProperty("Tab", $ELSCOPE_READONLY)
	$this.AddProperty("CanvasTab", $ELSCOPE_READONLY)
	$this.AddProperty("ParametersTab", $ELSCOPE_READONLY)
	$this.AddProperty("ScriptTab", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorerTab", $ELSCOPE_READONLY)

	$this.AddProperty("Parent", $ELSCOPE_READONLY, $parent)

	$this.AddProperty("Canvas", $ELSCOPE_READONLY, CanvasTab())
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, ParametersTab())
	$this.AddProperty("Script", $ELSCOPE_READONLY, ScriptTab())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY, ObjectExplorerTab())

	Return $this.Object
EndFunc   ;==>MainTab

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab(92 * $g_iDPI_ratio1, 5 * $g_iDPI_ratio1, 390 * $g_iDPI_ratio1, 24 * $g_iDPI_ratio1)

	GUICtrlSetResizing($this.Tab, $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

	$this.CanvasTab = GUICtrlCreateTabItem("Canvas")

	GUICtrlCreateTabItem('')

	$this.ParametersTab = GUICtrlCreateTabItem("Parameters")

	GUICtrlCreateTabItem('')

	$this.ScriptTab = GUICtrlCreateTabItem("Script")

	GUICtrlCreateTabItem('')

	$this.ObjectExplorerTab = GUICtrlCreateTabItem("Object Explorer")

	GUICtrlCreateTabItem('')

	$this.Canvas.Create($this.Parent)

	$this.Parameters.Create($this.Parent)

	$this.Script.Create($this.Parent)

	$this.ObjectExplorer.Create($this.Parent)
EndFunc   ;==>MainTab_Create

Func MainTab_Handler(Const ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case $this.Canvas.NewForm
			Return "New Form"

		Case $this.Canvas.Erase
			Return "Erase Canvas"
	EndSwitch

	Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP
			Switch GUICtrlRead($this.Tab, $GUI_READ_EXTENDED)
				Case $this.CanvasTab
					$this.Canvas.Show()

					$this.Parameters.Hide()

					$this.Script.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ParametersTab
					$this.Parameters.Show()

					$this.Canvas.Hide()

					$this.Script.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ScriptTab
					$this.Script.Show()

					$this.Canvas.Hide()

					$this.Parameters.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ObjectExplorerTab
					$this.ObjectExplorer.Show()

					$this.Canvas.Hide()

					$this.Parameters.Hide()

					$this.Script.Hide()

					Return True
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_ShowCanvas(Const ByRef $this)
	GUICtrlSetState($this.Canvas, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ShowCanvas

Func MainTab_ShowParameters(Const ByRef $this)
	GUICtrlSetState($this.Parameters, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ShowParameters

Func MainTab_ShowScript(Const ByRef $this)
	GUICtrlSetState($this.Script, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ShowScript

Func MainTab_ShowObjectExplorer(Const ByRef $this)
	GUICtrlSetState($this.ObjectExplorer, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ShowObjectExplorer
