
#AutoIt3Wrapper_UseX64=n

Opt("WinTitleMatchMode", 1)
Opt("MouseCoordMode", 2)

#include <ButtonConstants.au3>
#include <ColorConstants.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <WinAPISysWin.au3>
#include <WindowsStylesConstants.au3>

#include "StringSize\StringSize.au3"
#include "AutoItObject\AutoItObject.au3"

#include "Canvas\Canvas.au3"
#include "FormManager\Form Manager.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Properties\Properties.au3"
#include "Tab\Tab.au3"
#include "View.au3"
#include "Model.au3"

_AutoItObject_Startup()

main()

Func main()
	Local $Guiscape = Guiscape()

	$Guiscape.Create()

	$Guiscape.CreateForm()
	
	$Guiscape.SetState("Default")

	Do
		Local $event = $Guiscape.Model.EventArrayToMap(GUIGetMsg($GUI_EVENT_ARRAY))

		Switch $event.ID
			Case $GUI_EVENT_NONE, $GUI_EVENT_MOUSEMOVE
				; do nothing
				
			Case $GUI_EVENT_CLOSE
				If $event.Form = $Guiscape.View.Hwnd Then
					Quit()
				EndIf

			Case Else
				Switch $Guiscape.State
					Case "Default"
						$Guiscape.Handler($event)

					Case "Create"
						$Guiscape.CreateHandler($event)
				EndSwitch
		EndSwitch
	Until False
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Guiscape_Handler")
	$this.AddMethod("CreateHandler", "Guiscape_CreateHandler")
	$this.AddMethod("Create", "Guiscape_Create")
	$this.AddMethod("CreateForm", "Guiscape_CreateForm")
	$this.AddMethod("SetState", "Guiscape_SetState")

	$this.AddProperty("Model", $ELSCOPE_READONLY, Model())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Tab", $ELSCOPE_READONLY, Tab())
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Properties", $ELSCOPE_READONLY, Properties())
	$this.AddProperty("FormManager", $ELSCOPE_READONLY, FormManager())
	$this.AddProperty("State", $ELSCOPE_READONLY, "Default")

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_Handler(ByRef $this, Const ByRef $event)	
	Switch $this.Canvas.Handler($event)
		Case "Canvas"
			$this.FormManager.SetActiveForm(Null)

			Return True
	EndSwitch

	Switch $this.FormManager.Handler($event)
		Case True
			Local $form = $this.FormManager.GetForm($event.Form)

			$this.FormManager.SetActiveForm($form)

			Return True
	EndSwitch

	Switch $this.Toolbar.Handler($event.ID)
		Case "Form"
			$this.CreateForm()

			Return True

		Case "Button"			
			$this.SetState("Create")

			$this.FormManager.SetState("Create")
			
			Return True
	EndSwitch

	Switch $this.Tab.Handler($event.ID)
		Case "Canvas"
			$this.Canvas.Show

			Return True

		Case "Properties"
			$this.Canvas.Hide()

			$this.Properties.Show()

			Return True

		Case "Script"
			$this.Canvas.Hide()

			$this.Properties.Hide()

			Return True

		Case "Object Explorer"
			$this.Canvas.Hide()

			$this.Properties.Hide()

			Return True
	EndSwitch

	Switch $this.Menubar.Handler($event.ID)
		Case "Handled"

			Return True

		Case "Save"

			Return True

		Case "Load"

			Return True

		Case "Exit"
			Quit()
	EndSwitch
EndFunc   ;==>Guiscape_Handler

Func Guiscape_CreateHandler(ByRef $this, Const $event)		
	Switch $this.Canvas.Handler($event)
		Case "Canvas"
			$this.FormManager.SetActiveForm(Null)
			
			$this.SetState("Default")
			
			$this.FormManager.State = "Default"

			Return True
	EndSwitch

	Switch $this.FormManager.Handler($event)			
		Case "Create"						
			$this.SetState("Default")
			
			$this.FormManager.SetState("Default")

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_CreateButtonHandler

Func Guiscape_Create(ByRef $this)
	$this.View.Create($this.Model.Title)

	$this.Menubar = Menubar($this.Model.ResourcesDir)

	$this.Menubar.Create()

	$this.Menubar.Initialize()

	$this.Toolbar = Toolbar($this.Model.ResourcesDir)

	$this.Toolbar.Create()

	$this.Tab.Create()

	$this.Canvas.Create($this.View)

	$this.Properties.Create($this.View)

	$this.Canvas.Show()

	$this.View.Show()

	Return True
EndFunc   ;==>Guiscape_Create

Func Guiscape_SetState(ByRef $this, Const $state, Const $n = '')
	$this.State = $state
EndFunc

Func Guiscape_CreateForm(ByRef $this)
	Local $form = Form($this.Canvas.View.Hwnd)

	$this.FormManager.Add($form)

	$form.SetTitle("Form" & $this.FormManager.FormCount)

;~ 	$this.Properties.FormStyles.Initialize($this.FormManager.GetStyle())

;~ 	$this.Properties.FormExStyles.Initialize($this.FormManager.GetExStyle())

;~ 	GUICtrlSetData($this.Properties.Title, $this.FormManager.Title)
;~ 	GUICtrlSetData($this.Properties.Width, $this.FormManager.Width)
;~ 	GUICtrlSetData($this.Properties.Height, $this.FormManager.Height)
;~ 	GUICtrlSetData($this.Properties.Left, $this.FormManager.Left)
;~ 	GUICtrlSetData($this.Properties.Top, $this.FormManager.Top)
EndFunc   ;==>Guiscape_CreateForm

Func Quit()
	Exit
EndFunc   ;==>Quit
