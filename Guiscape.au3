
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
#AutoIt3Wrapper_Res_HiDpi=n  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail!
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>

#include "AutoItObject.au3"
#include "_WinAPI_DPI.au3"
#include "Canvas\Canvas.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Properties\Properties.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Tab\Tab.au3"
#include "View.au3"
#include "Model.au3"

_AutoItObject_Startup()

main()

Func main()
	Local $Guiscape = Guiscape()

	$Guiscape.Create()

	$Guiscape.Canvas.GUIObject.Create()

	$Guiscape.Properties.FormStyles.Initialize($Guiscape.Canvas.GUIObject.GetStyle())

	$Guiscape.Properties.FormExStyles.Initialize($Guiscape.Canvas.GUIObject.GetExStyle())

	Do
		Local $event = $Guiscape.Model.GUIEvent()

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

			Case $GUI_EVENT_RESIZED
				Switch $event.Form
					Case $Guiscape.View.Hwnd
						$Guiscape.View.SetSizePos(WinGetPos($event.Form))
						
					Case Else
						ContinueLoop
				EndSwitch

			Case $GUI_EVENT_CLOSE
				; Ask if the Designer would like to save their progress before closing the window.

				If $event.Form = $Guiscape.View.Hwnd Then
					_Exit($Guiscape, $event)
				Else
					; To-Do: Send this event to the Canvas for processing
					
					GUIDelete($event.Form)
				EndIf
		EndSwitch

		Switch $Guiscape.Canvas.Handler($event)
			Case "Erase Canvas"
				; Ask if the Designer would like to save their progress before erasing the canvas.

				ContinueLoop

			Case True
				ContinueLoop
		EndSwitch

		; Allows the Designer to select from a form or a control to create. If the Designer chooses "Form" then the Canvas is
		; sent into "Create" mode at which point it will wait for the Designer to click on the canvas. At that point a form
		; will be created. Otherwise, if the Designer wishes to place a control on a form then a control is selected in the
		; toolbar and then the form is sent into Create mode and will wait for the designer to click on it.
		Switch $Guiscape.Toolbar.Handler($event.ID)
			Case "Form"
				$Guiscape.Canvas.GUIObject.Create()

				$Guiscape.Properties.FormStyles.Initialize($Guiscape.Canvas.GUIObject.GetStyle())

				$Guiscape.Properties.FormExStyles.Initialize($Guiscape.Canvas.GUIObject.GetExStyle())

				ContinueLoop

			Case "Button"
				$Guiscape.Canvas.GUIObject.CreateButton()

				ContinueLoop

			Case "Checkbox"
				ContinueLoop
		EndSwitch

		; Shows and hides tabs
		Switch $Guiscape.Tab.Handler($event)
			Case "Canvas"
				$Guiscape.Canvas.Show

				$Guiscape.Properties.Hide()

				$Guiscape.Script.Hide()
				
				$Guiscape.ObjectExplorer.Hide()

				ContinueLoop

			Case "Properties"
				$Guiscape.Properties.Show()

				$Guiscape.Canvas.Hide()

				$Guiscape.Script.Hide()
				
				$Guiscape.ObjectExplorer.Hide()

				ContinueLoop

			Case "Script"
				$Guiscape.Script.Show()

				$Guiscape.Canvas.Hide()

				$Guiscape.Properties.Hide()
				
				$Guiscape.ObjectExplorer.Hide()

				ContinueLoop

			Case "Object Explorer"
				$Guiscape.ObjectExplorer.Show()

				$Guiscape.Canvas.Hide()

				$Guiscape.Properties.Hide()

				$Guiscape.Script.Hide()

				ContinueLoop
		EndSwitch

		; To-Do: Handle all menu bar items
		Switch $Guiscape.Menubar.Handler($event.ID)
			Case "Handled"
				ContinueLoop

			Case "Save"
				ContinueLoop

			Case "Load"
				ContinueLoop

			Case "Exit"
				; Ask if the Designer would like to save their progress before closing the window.
				_Exit($Guiscape, $event)
		EndSwitch
	Until False
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Guiscape_Create")

	$this.AddProperty("Model", $ELSCOPE_READONLY, GUIScapeModel())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, Menubar())
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY, Toolbar())
	$this.AddProperty("Script", $ELSCOPE_READONLY, Script())
	$this.AddProperty("ObjectExplorer", $ELSCOPE_READONLY, ObjectExplorer())
	$this.AddProperty("Tab", $ELSCOPE_READONLY, Tab())
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Properties", $ELSCOPE_READONLY, Properties())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_Create(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar.Create()
	
	$this.Menubar.View.Initialize($this.Model.GetSettings())

	$this.Toolbar.Create($this.Model.ResourcesDir)

	$this.Tab.Create()

	$this.Canvas.Create($this.View)

	$this.Properties.Create($this.View)

	$this.Script.Create($this.View)
	
	$this.ObjectExplorer.Create($this.View)
	
	$this.ObjectExplorer.Show()

	$this.Canvas.Show()

	$this.View.Show()

	Return True
EndFunc   ;==>Guiscape_Create

Func _Exit(ByRef $Guiscape, Const ByRef $event)
	#forceref $Guiscape, $event
	
	Exit
EndFunc   ;==>_Exit

;~ Func HWndFromPoint()
;~ 	Local Static $g_tStruct = DllStructCreate($tagPOINT)

;~ 	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

;~ 	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

;~ 	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

;~ 	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

;~ 	;Return _WinAPI_GetClassName($hwnd)
;~ 	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
;~ EndFunc   ;==>HWndFromPoint
