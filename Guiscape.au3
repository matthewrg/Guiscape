
#include "Boilerplate.au3"

Global $Guiscape = Guiscape()

RegisterEvents()

$Guiscape.InitView()

$Guiscape.CreateForm()

Do
	$Guiscape.Handler()
Until False

#Region ; Guiscape

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("InitView", "Guiscape_InitView")
	$this.AddMethod("Handler", "Guiscape_Handler")
	$this.AddMethod("CreateForm", "Guiscape_CreateForm")

	$this.AddMethod("GUIObjectsHandler", "Guiscape_GUIObjectsHandler", True)
	$this.AddMethod("MenubarHandler", "Guiscape_Menubar_Handler", True)
	$this.AddMethod("ToolbarHandler", "Guiscape_Toolbar_Handler", True)
	$this.AddMethod("TabHandler", "Guiscape_Tab_Handler", True)
	$this.AddMethod("ParametersHandler", "Guiscape_Parameters_Handler", True)
	$this.AddMethod("ObjectExplorerHandler", "Guiscape_Script_Handler", True)
	$this.AddMethod("CanvasHandler", "Guiscape_ObjectExplorer_Handler", True)

	$this.AddProperty("Model", $ELSCOPE_PRIVATE, GUIScapeModel())
	$this.AddProperty("View", $ELSCOPE_PRIVATE, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_PRIVATE, Menubar())
	$this.AddProperty("Toolbar", $ELSCOPE_PRIVATE, Toolbar())
	$this.AddProperty("Tab", $ELSCOPE_PRIVATE)
	$this.AddProperty("Script", $ELSCOPE_PRIVATE, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_PRIVATE, ObjectExplorer())
	$this.AddProperty("GUIObjects", $ELSCOPE_PRIVATE, GUIObjects())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_InitView(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar.Create()

	$this.Menubar.Initialize($this.Model.GetSettings())

	$this.Toolbar.Create($this.Model.ResourcesDir)

	$this.Tab = MainTab($this.View)

	$this.View.Show()

	$this.Tab.Create()

;~ 	$this.Tab.Canvas.Show()

	$this.Tab.ActivateParametersTab()

	$this.Tab.Parameters.Form.Show()

	Return True
EndFunc   ;==>Guiscape_InitView

Func Guiscape_Handler(ByRef $this)
	Local Const $event = $this.Model.GUIEvent()

	Switch $event.ID
		Case $GUI_EVENT_NONE
			Return True

		Case $GUI_EVENT_RESIZED
			Switch $event.Form
				Case $this.View.Hwnd
					Local $sizePos = WinGetPos($event.Form)

					$this.View.SetSizePos($sizePos)

					$this.Tab.Canvas.Move($sizePos)
			EndSwitch

		Case $GUI_EVENT_CLOSE
			; Ask if the Designer would like to save their progress before closing the window.

			Switch $event.Form
				Case $this.View.Hwnd
					_Exit($this, $event)

				Case Else
					$this.GUIObjects.RemoveForm($event.Form)

					Return True
			EndSwitch
	EndSwitch

	If $this.GUIObjectsHandler($event) Then Return True

	If $this.MenubarHandler($event) Then Return True

	If $this.ToolbarHandler($event) Then Return True

	If $this.TabHandler($event) Then Return True
EndFunc   ;==>Guiscape_Handler

Func Guiscape_GUIObjectsHandler(ByRef $this, Const ByRef $event)
	Switch $this.GUIObjects.Handler($event)
		Case "Form Selected"
			Local Const $form = $this.GUIObjects.GetActiveObject()

			$this.Tab.Parameters.Form.Init($form)

			$this.Tab.Parameters.Form.Show()

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_GUIObjectsHandler

Func Guiscape_Menubar_Handler(ByRef $this, Const ByRef $event)
	; To-Do: Handle all menu bar items
	Local Const $menubar = $this.Menubar.Handler($event.ID)

	If IsMap($menubar) Then
		Switch $menubar.Message
			Case "Save"
				Return True

			Case "Load"
				Return True

			Case "Exit"
				_Exit($this, $event)

			Case "Canvas"
				$this.Tab.ShowCanvas()

				Return True

			Case "Parameters"
				$this.Tab.ShowParameters()

				Return True

			Case "Script"
				$this.Tab.ShowScript()

				Return True

			Case "Object Explorer"
				$this.Tab.ShowObjectExplorer()

				Return True

			Case "ShowGrid", "SnapToGrid", "PasteAtMousePosition", "ShowControlWhenMoving", "ShowHiddenControls"
				$this.Model.WriteSetting($menubar.Message, $menubar.Setting)

				Return True
		EndSwitch
	Else
		Return False
	EndIf
EndFunc   ;==>Guiscape_Menubar_Handler

Func Guiscape_Toolbar_Handler(ByRef $this, Const ByRef $event)
	; Allows the Designer to select from a form or a control to create. If the Designer chooses "Form" then the Canvas is
	; sent into "Create" mode at which point it will wait for the Designer to click on the canvas. At that point a form
	; will be created. Otherwise, if the Designer wishes to place a control on a form then a control is selected in the
	; toolbar and then the form is sent into Create mode and will wait for the designer to click on it.
	Switch $this.Toolbar.Handler($event.ID)
		Case "Form"
			$this.CreateForm()

			Return True

		Case "Group"
			Return True

		Case "Button"
			Return True

		Case "Checkbox"
			Return True

		Case "Radio"
			Return True

		Case "Edit"
			Return True

		Case "Input"
			Return True

		Case "Label"
			Return True

		Case "UpDown"
			Return True

		Case "List"
			Return True

		Case "Combo"
			Return True

		Case "Date"
			Return True

		Case "Treeview"
			Return True

		Case "Progress"
			Return True

		Case "Avi"
			Return True

		Case "Icon"
			Return True

		Case "Pic"
			Return True

		Case "Slider"
			Return True

		Case "Tab"
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Toolbar_Handler

Func Guiscape_Tab_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Tab.Handler($event)
		Case "Erase Canvas"
			; Ask if the Designer would like to save their progress before erasing the canvas.

			Return True

		Case "New Form"
			Return True

		Case "Canvas Clicked"
			$this.GUIObjects.UnSetActiveObject()
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Tab_Handler

Func Guiscape_Parameters_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event

EndFunc   ;==>Guiscape_Parameters_Handler

Func Guiscape_Script_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event

EndFunc   ;==>Guiscape_Script_Handler

Func Guiscape_ObjectExplorer_Handler(ByRef $this, Const ByRef $event)
	#forceref $this, $event

EndFunc   ;==>Guiscape_ObjectExplorer_Handler

Func Guiscape_CreateForm(ByRef $this)
	$this.GUIObjects.Create($this.Tab.Canvas.Hwnd)

	Local Const $form = $this.GUIObjects.GetActiveObject()

	$form.Show()

	$this.Tab.Parameters.Form.Init($form)

	$this.Tab.Parameters.Form.Show()
EndFunc   ;==>Guiscape_CreateForm

Func Print(Const ByRef $message)
	ConsoleWrite($message & @CRLF)
EndFunc   ;==>Print

Func _Exit(ByRef $Guiscape, Const ByRef $event)
	#forceref $Guiscape, $event

	Exit
EndFunc   ;==>_Exit

Func GUIObjectsEvents($hWnd, $msg, $wParam, $lParam)
	#forceref $wParam, $lParam

	Local $event[]

	$event.ID = $msg
	$event.Form = $hWnd

	$Guiscape.GUIObjects.Handler($event)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIObjectsEvents

Func CanvasEvents($hWnd, $msg, $wParam, $lParam)
	#forceref $wParam, $lParam

	Local $event[]

	$event.ID = $msg
	$event.Form = $hWnd

	$Guiscape.Tab.Handler($event)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>CanvasEvents

Func RegisterEvents()
	; GUIObjects
	GUIRegisterMsg($WM_SIZE, GUIObjectsEvents)
	GUIRegisterMsg($WM_NCLBUTTONDOWN, GUIObjectsEvents)

	; Canvas
	GUIRegisterMsg($WM_SIZE, CanvasEvents)
EndFunc   ;==>RegisterEvents
