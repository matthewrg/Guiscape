
; Roadmap: Currently working on laying out the GUI in it's entirety
; once that's done then begin working on fleshing out the actual GUI designer code
; which MattyD has made some contributions toward in the forum post.
; I plan to Work in MattyD's contributions once I get to that point unless he wants to do it.
; A future plan is to allow an au3 to be dropped on Guiscape and then display
; the GUI elements found within so that they can be edited and then written back to the au3.
; Another future plan is to generate GUI code for other languages

; The "Canvas" maintains a list of Forms which are self contained objects that create their own controls,
; and otherwise maintain their own state.  Currently, it's only a fraction of the intended behavior.

#AutoIt3Wrapper_Change2CUI=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#AutoIt3Wrapper_Res_HiDpi=Y  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail!
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>

#include "AutoItObject.au3"
#include "_WinAPI_DPI.au3"
#include "Model.au3"
#include "View.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Main Tab\Main Tab.au3"
#include "Script\Script.au3"
#include "Parameters\Parameters.au3"
#include "Object Explorer\Object Explorer.au3"
#include "GUI Objects\GUI Objects.au3"

#Region ; Guiscape

_AutoItObject_Startup()

Global $Guiscape = Guiscape()

GUIRegisterMsg($WM_SIZE, FormEvents)
GUIRegisterMsg($WM_NCLBUTTONDOWN, FormEvents)

$Guiscape.Create()

$Guiscape.CreateForm()

Do
	$Guiscape.Handler()
Until False

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Guiscape_Create")
	$this.AddMethod("Handler", "Guiscape_Handler")
	$this.AddMethod("CreateForm", "Guiscape_CreateForm")

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
	$this.AddProperty("Parameters", $ELSCOPE_PRIVATE, Parameters())
	$this.AddProperty("Script", $ELSCOPE_PRIVATE, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_PRIVATE, ObjectExplorer())
	$this.AddProperty("GUIObjects", $ELSCOPE_PRIVATE, GUIObjects())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_Create(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar.Create()

	$this.Menubar.Initialize($this.Model.GetSettings())

	$this.Toolbar.Create($this.Model.ResourcesDir)

	$this.Tab = MainTab($this.View)

	$this.Tab.Create()

	$this.View.Show()

	$this.Tab.Canvas.Show()

	Return True
EndFunc   ;==>Guiscape_Create

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

	If $this.GUIObjects.Handler($event) Then Return True

	If $this.TabHandler($event) Then Return True

	If $this.MenubarHandler($event) Then Return True

	If $this.ToolbarHandler($event) Then Return True
EndFunc   ;==>Guiscape_Handler

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
	EndSwitch
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

	$this.GUIObjects.ActiveForm.Show()

;~ 	$this.Properties.FormStyles.Initialize($this.Canvas.GUIObject.GetStyle())

;~ 	$this.Properties.FormExStyles.Initialize($this.Canvas.GUIObject.GetExStyle())
EndFunc   ;==>Guiscape_CreateForm

Func Print(Const $message)
	ConsoleWrite($message & @CRLF)
EndFunc   ;==>Print

Func _Exit(ByRef $Guiscape, Const ByRef $event)
	#forceref $Guiscape, $event

	Exit
EndFunc   ;==>_Exit

Func FormEvents($hWnd, $msg, $wParam, $lParam)
	#forceref $wParam, $lParam

	Local $event[]

	$event.ID = $msg
	$event.Form = $hWnd

	$Guiscape.GUIObjects.Handler($event)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>FormResized

;~ Func HWndFromPoint()
;~ 	Local Static $g_tStruct = DllStructCreate($tagPOINT)

;~ 	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

;~ 	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

;~ 	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

;~ 	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

;~ 	;Return _WinAPI_GetClassName($hwnd)
;~ 	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
;~ EndFunc   ;==>HWndFromPoint

#EndRegion ; Guiscape
