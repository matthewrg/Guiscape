
#include-once

#Autoit3Wrapper_Testing=Y
#AutoIt3Wrapper_Run_Debug_Mode=N
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
#Au3Stripper_Parameters=/mo/rsln
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d
#AutoIt3Wrapper_Run_Au3Check=Y
#AutoIt3Wrapper_Run_Tidy=N

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
;~ Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <WindowsNotifsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>
#include <Misc.au3>
#include <GuiTab.au3>

#include "AutoItObject\AutoItObject.au3"
#include "_WinAPI_DPI\_WinAPI_DPI.au3"
#include "Resources\Extras.au3"
#include "Model.au3"
#include "View.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Canvas\Canvas.au3"
#include "Parameters\Parameters.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Settings\Settings.au3"
#include "GUI Objects\GUI Objects.au3"

_AutoItObject_Startup()

#Region ; Guiscape
	
Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)

Global $dummy

Global Const $NC_CLICKED = 1

main()

Func main()
	Local $Guiscape = Guiscape()
	
	$Guiscape.InitView()
	
	GUIRegisterMsg($WM_NCLBUTTONDOWN, GUIObjectsEvent)
	
	$dummy = GUICtrlCreateDummy()
	
	Do
		$Guiscape.Handler()
	Until False
EndFunc

Func GUIObjectsEvent($hwnd, $msg, $wParam, $lParam)
	#forceref $hwnd, $msg, $wParam, $lParam
	
	GUICtrlSendToDummy($dummy, _WinAPI_MakeLong($NC_CLICKED, $hwnd))
	
	Return $GUI_RUNDEFMSG 
EndFunc

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("InitView", "Guiscape_InitView")
	$this.AddMethod("Handler", "Guiscape_Handler")

	$this.AddMethod("ViewHandler", "Guiscape_View_Handler", True)
	$this.AddMethod("MenubarHandler", "Guiscape_Menubar_Handler", True)
	$this.AddMethod("ToolbarHandler", "Guiscape_Toolbar_Handler", True)
	$this.AddMethod("CanvasHandler", "Guiscape_Canvas_Handler", True)
	$this.AddMethod("ParametersHandler", "Guiscape_Parameters_Handler", True)
	$this.AddMethod("ScriptHandler", "Guiscape_Script_Handler", True)
	$this.AddMethod("ObjectExplorerHandler", "Guiscape_ObjectExplorer_Handler", True)
	$this.AddMethod("SettingsHandler", "Guiscape_Settings_Handler", True)
	$this.AddMethod("GUIObjectsHandler", "Guiscape_GUIObjectsHandler", True)

	$this.AddProperty("Model", $ELSCOPE_READONLY, GuiscapeModel())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, Menubar())
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY, Toolbar())
	$this.AddProperty("GUIObjects", $ELSCOPE_READONLY)
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Parameters", $ELSCOPE_READONLY, Parameters())
	$this.AddProperty("Script", $ELSCOPE_READONLY, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY, ObjectExplorer())
	$this.AddProperty("Settings", $ELSCOPE_READONLY, Settings())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_InitView(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar.Create($this.Model.GetSettings())

	$this.Toolbar.Create($this.Model.ResourcesDir)

	$this.Canvas.Create($this.View)
	
	$this.Parameters.Create($this.View)

	$this.Script.Create($this.View)

	$this.ObjectExplorer.Create($this.View)

	$this.Settings.Create($this.View)

	$this.GUIObjects = GUIObjects($this.Canvas.Hwnd)

	$this.View.Show()
	
	$this.Canvas.Show()
	
	$this.GUIObjectsHandler(CreateMessage("Create Form"))
	
	Return True
EndFunc   ;==>Guiscape_InitView

Func Guiscape_Handler(ByRef $this)
	Local Const $event = $this.Model.GUIEvent()

	If Not IsMap($event) Then Return False

	Switch $event.ID
		Case $GUI_EVENT_RESIZED
			Switch $event.Form
				Case $this.View.Hwnd
					$this.View.SetSizePos()
			EndSwitch
			
		Case $dummy			 			
			Local $iActionCommand = GUICtrlRead($dummy)
			
			If _WinAPI_LoWord($iActionCommand) = $NC_CLICKED Then
				Print("What is this? It changes depending on the title bar that is clicked. " & _WinAPI_HiWord($iActionCommand))			
			
				Return True
			EndIf

		Case $GUI_EVENT_CLOSE
			; Ask if the Designer would like to save their progress before closing the window.

			Switch $event.Form
				Case $this.View.Hwnd
					_Exit($this, $event)

				Case Else
					$this.Parameters.Hide()
			EndSwitch
	EndSwitch
	
	If $this.ViewHandler($event) Then Return True

	If $this.MenubarHandler($event) Then Return True

	If $this.ToolbarHandler($event) Then Return True

	If $this.CanvasHandler($event) Then Return True

	If $this.ParametersHandler($event) Then Return True

	If $this.ScriptHandler($event) Then Return True

	If $this.ObjectExplorerHandler($event) Then Return True

	If $this.SettingsHandler($event) Then Return True

	If $this.GUIObjectsHandler($event) Then Return True
EndFunc   ;==>Guiscape_Handler

Func Guiscape_View_Handler(ByRef $this, Const ByRef $event)
	Switch $this.View.Handler($event)
		Case "Canvas Tab"
			$this.Canvas.Show()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()
			
			Return True
			
		Case "Parameters Tab"
			$this.Canvas.Hide()
			$this.Parameters.Show()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()
			
			Return True
			
		Case "Script Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Show()
			$this.ObjectExplorer.Hide()
			$this.Settings.Hide()
			
			Return True
			
		Case "Object Explorer Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Show()
			$this.Settings.Hide()
			
			Return True
			
		Case "Settings Tab"
			$this.Canvas.Hide()
			$this.Parameters.Hide()
			$this.Script.Hide()
			$this.ObjectExplorer.Hide()
			$this.Settings.Show()
			
			Return True
	EndSwitch
	
	Return False
EndFunc

Func Guiscape_Menubar_Handler(ByRef $this, Const ByRef $event)
	; To-Do: Handle all menu bar items
	Local Const $menubar = $this.Menubar.Handler(CreateMessage($event.ID))

	If IsMap($menubar) Then
		Switch $menubar.Message
			Case "Save"
				Return True

			Case "Load"
				Return True

			Case "Exit"
				_Exit($this, $event)

			Case "Canvas"
;~ 				$this.ShowCanvasTab()

				Return True

			Case "Parameters"
;~ 				$this.ShowParametersTab()

				Return True

			Case "Script"
;~ 				$this.ShowScriptTab()

				Return True

			Case "Object Explorer"
;~ 				$this.ShowObjectExplorerTab()

				Return True

			Case "Settings"
;~ 				$this.ShowSettingsTab()

				Return True

			Case "ShowGrid", "SnapToGrid", "PasteAtMousePosition", "ShowControlWhenMoving", "ShowHiddenControls"
				$this.Model.WriteSetting($menubar.Message, $menubar.Setting)

				Return True
		EndSwitch
	Else
		Return False
	EndIf
EndFunc   ;==>Guiscape_Menubar_Handler

Func Guiscape_Toolbar_Handler(ByRef $this, ByRef $event)
	; Allows the Designer to select from a form or a control to create. If the Designer chooses "Form" then the Canvas is
	; sent into "Create" mode at which point it will wait for the Designer to click on the canvas. At that point a form
	; will be created. Otherwise, if the Designer wishes to place a control on a form then a control is selected in the
	; toolbar and then the form is sent into Create mode and will wait for the designer to click on it.
	
	Switch $this.Toolbar.Handler($event)
		Case "Form"
			$this.GUIObjectsHandler(CreateMessage("Create Form"))

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

Func Guiscape_Canvas_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Canvas.Handler($event)
		Case "Erase Canvas"
			; Ask if the Designer would like to save their progress before erasing the canvas.

			Return True

		Case "Create Form"
			$this.GUIObjectsHandler(CreateMessage("Create Form"))

			Return True

		Case "Canvas Clicked"
			$this.ParametersHandler(CreateMessage("Form Deselected"))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Canvas_Handler

Func Guiscape_Parameters_Handler(ByRef $this, Const ByRef $event)		
	Switch $this.Parameters.Handler($event)
		Case True		
			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Parameters_Handler

Func Guiscape_Script_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Script.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Script_Handler

Func Guiscape_ObjectExplorer_Handler(ByRef $this, Const ByRef $event)
	Switch $this.ObjectExplorer.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_ObjectExplorer_Handler

Func Guiscape_Settings_Handler(ByRef $this, Const ByRef $event)
	Switch $this.Settings.Handler($event)
		Case True

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Settings_Handler

Func Guiscape_GUIObjectsHandler(ByRef $this, Const ByRef $event)	
	Switch $event.ID
		Case "Create Form"			
			Local $form = $this.GUIObjects.Create()	
			
			$form = $this.GUIObjects.GetForm($form.GetHwnd())
			
			$this.ParametersHandler(CreateMessage("Initialize Form", $form))
			
			Return True
			
		Case $NC_CLICKED	
			
	EndSwitch
	
	Switch $this.GUIObjects.Handler($event)
		Case "Form Selected"
			$form = $this.GUIObjects.GetForm($event.Form)
			
			$this.ParametersHandler(CreateMessage("Initialize Form", $form))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_GUIObjectsHandler

Func CreateMessage(Const ByRef $message, $form = Null)	
	Local $event[]
	
	$event.ID = $message
	
	$event.Form = $form
	
	Return $event
EndFunc

#EndRegion ; Guiscape

Func _ErrFunc()
	 ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
            @TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
            @TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & @CRLF)
EndFunc
