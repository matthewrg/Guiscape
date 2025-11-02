
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

	$Guiscape.CreateForm()

	Do
		Local $event = $Guiscape.Model.EventArrayToMap(GUIGetMsg($GUI_EVENT_ARRAY))

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

			Case $GUI_EVENT_CLOSE
				If $event.Form = $Guiscape.View.Hwnd Then
					Quit()
				EndIf
				
		  Case Else
			$Guiscape.Handler($event)
		EndSwitch

		
	Until False
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Guiscape_Handler")
	$this.AddMethod("Create", "Guiscape_Create")
	$this.AddMethod("CreateForm", "Guiscape_CreateForm")

	$this.AddProperty("Model", $ELSCOPE_READONLY, Model())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY, Null)
	$this.AddProperty("Tab", $ELSCOPE_READONLY, Tab())
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Properties", $ELSCOPE_READONLY, Properties())
	$this.AddProperty("FormManager", $ELSCOPE_READONLY, FormManager())

	Return $this.Object
EndFunc   ;==>Guiscape

Func Guiscape_Handler(ByRef $this, Const $event)
	Switch $this.Canvas.Handler($event)
		Case "Canvas"
			$this.FormManager.SetActiveForm(Null)
	EndSwitch

	Switch $this.FormManager.Handler($event)
		Case True
			Local $form = $this.FormManager.GetForm($event.Form)

			$this.FormManager.SetActiveForm($form)
	EndSwitch

	Switch $this.Toolbar.Handler($event.ID)
		Case "Form"
			$this.CreateForm()

		Case "Button"
			$this.State = GuiscapeCreate()
	EndSwitch

	Switch $this.Tab.Handler($event.ID)
		Case "Canvas"
			$this.Canvas.Show

		Case "Properties"
			$this.Canvas.Hide()

			$this.Properties.Show()

		Case "Script"
			$this.Canvas.Hide()

			$this.Properties.Hide()

		Case "Object Explorer"
			$this.Canvas.Hide()

			$this.Properties.Hide()
	EndSwitch

	Switch $this.Menubar.Handler($event.ID)
		Case "Handled"

		Case "Save"

		Case "Load"

		Case "Exit"
			Quit()
	EndSwitch
EndFunc   ;==>Guiscape_Handler

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

Func GuiscapeCreate()

EndFunc   ;==>GuiscapeCreate

Func GuiscapeCreate_Handler(ByRef $this, Const $event)
		Switch $this.Canvas.Handler($event)
			Case "Canvas"
				$this.FormManager.SetActiveForm(Null)
		EndSwitch

		Switch $this.FormManager.Handler($event)
			Case True
				Local $form = $this.FormManager.GetForm($event.Form)

				$this.FormManager.SetActiveForm($form)
		EndSwitch

		Switch $this.Toolbar.Handler($event.ID)
			Case "Form"
				$this.CreateForm()

			Case "Button"
				$this.State = GuiscapeCreate()
		EndSwitch

		Switch $this.Tab.Handler($event.ID)
			Case "Canvas"
				$this.Canvas.Show

			Case "Properties"
				$this.Canvas.Hide()

				$this.Properties.Show()

			Case "Script"
				$this.Canvas.Hide()

				$this.Properties.Hide()

			Case "Object Explorer"
				$this.Canvas.Hide()

				$this.Properties.Hide()
		EndSwitch

		Switch $this.Menubar.Handler($event.ID)
			Case "Handled"

			Case "Save"

			Case "Load"

			Case "Exit"
				Quit()
		EndSwitch
EndFunc   ;==>GuiscapeCreate_Handler

Func Quit()
	Exit
EndFunc   ;==>Quit
