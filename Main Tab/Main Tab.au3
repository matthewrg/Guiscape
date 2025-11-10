
#include-once

#include <GUIConstantsEx.au3>
#include <WinApiGdi.au3>

#include "Canvas.au3"
#include "Parameters.au3"
#include "Script.au3"
#include "Object Explorer.au3"

Func MainTab(Const $parent)
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "MainTab_Create")
	$this.AddMethod("Handler", "MainTab_Handler")
	$this.AddMethod("ActivateCanvasTab", "MainTab_ActivateCanvasTab")
	$this.AddMethod("ActivateParametersTab", "MainTab_ActivateParametersTab")
	$this.AddMethod("ActivateScriptTab", "MainTab_ActivateScriptTab")
	$this.AddMethod("ActivateObjectExplorerTab", "MainTab_ActivateObjectExplorerTab")

	$this.AddProperty("CanvasTab", $ELSCOPE_READONLY)
	$this.AddProperty("ParametersTab", $ELSCOPE_READONLY)
	$this.AddProperty("ScriptTab", $ELSCOPE_READONLY)
	$this.AddProperty("ObjectExplorerTab", $ELSCOPE_READONLY)

	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, Parameters())
	$this.AddProperty("Script", $ELSCOPE_READONLY, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY, ObjectExplorer())

	$this.AddProperty("Tab", $ELSCOPE_PRIVATE)
	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, $parent)

	Return $this.Object
EndFunc   ;==>MainTab

Func MainTab_Create(ByRef $this)
	$this.Tab = GUICtrlCreateTab(92 * $DPIRatio, 5 * $DPIRatio, 390 * $DPIRatio, 24 * $DPIRatio)

	GUICtrlSetResizing(HWnd($this.Tab), $GUI_DOCKLEFT + $GUI_DOCKSIZE + $GUI_DOCKTOP)

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

	$this.ActivateCanvasTab()
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
			Switch WinGetTitle($event.Form)
				Case "Canvas"
					Return "Canvas Clicked"
			EndSwitch

			Switch GUICtrlRead($this.Tab, $GUI_READ_EXTENDED)
				Case $this.CanvasTab
					$this.Canvas.Show()

					$this.Parameters.Active.Hide()

					$this.Script.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ParametersTab
					$this.Parameters.Active.Show()

					$this.Canvas.Hide()

					$this.Script.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ScriptTab
					$this.Script.Show()

					$this.Canvas.Hide()

					$this.Parameters.Active.Hide()

					$this.ObjectExplorer.Hide()

					Return True

				Case $this.ObjectExplorerTab
					$this.ObjectExplorer.Show()

					$this.Canvas.Hide()

					$this.Parameters.Active.Hide()

					$this.Script.Hide()

					Return True
			EndSwitch
	EndSwitch

	If $this.Parameters.Form.Handler($event) Then
		Return True
	EndIf

	Return False
EndFunc   ;==>MainTab_Handler

Func MainTab_ActivateCanvasTab(Const ByRef $this)
	GUICtrlSetState($this.CanvasTab, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ActivateCanvasTab

Func MainTab_ActivateParametersTab(Const ByRef $this)
	GUICtrlSetState($this.ParametersTab, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ActivateParametersTab

Func MainTab_ActivateScriptTab(Const ByRef $this)
	GUICtrlSetState($this.ScriptTab, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ActivateScriptTab

Func MainTab_ActivateObjectExplorerTab(Const ByRef $this)
	GUICtrlSetState($this.ObjectExplorerTab, $GUI_SHOW + $GUI_FOCUS)
EndFunc   ;==>MainTab_ActivateObjectExplorerTab
