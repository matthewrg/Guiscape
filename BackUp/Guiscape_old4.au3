
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

				ContinueLoop
		EndSwitch

		$Guiscape.Handler($event)
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
	Switch $Guiscape.Canvas.Handler($event)
		Case "Canvas"
			$Guiscape.FormManager.SetActiveForm(Null)
	EndSwitch

	Switch $Guiscape.FormManager.Handler($event)
		Case True
			Local $form = $Guiscape.FormManager.GetForm($event.Form)

			$Guiscape.FormManager.SetActiveForm($form)
	EndSwitch

	Switch $Guiscape.Toolbar.Handler($event.ID)
		Case "Form"
			$Guiscape.CreateForm()

		Case "Button"
			$Guiscape.State = GuiscapeCreate()
	EndSwitch

	Switch $Guiscape.Tab.Handler($event.ID)
		Case "Canvas"
			$Guiscape.Canvas.Show
			
		Case "Properties"
			$Guiscape.Canvas.Hide()

			$Guiscape.Properties.Show()

		Case "Script"
			$Guiscape.Canvas.Hide()

			$Guiscape.Properties.Hide()

		Case "Object Explorer"
			$Guiscape.Canvas.Hide()

			$Guiscape.Properties.Hide()
	EndSwitch

	Switch $Guiscape.Menubar.Handler($event.ID)
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
	Do
		Local $event = $Guiscape.Model.EventArrayToMap(GUIGetMsg($GUI_EVENT_ARRAY))

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

			Case $GUI_EVENT_CLOSE
				If $event.Form = $Guiscape.View.Hwnd Then
					Quit()
				EndIf

				ContinueLoop
		EndSwitch

		Switch $Guiscape.Canvas.Handler($event)
			Case "Canvas"
				$Guiscape.FormManager.SetActiveForm(Null)

				ContinueLoop
		EndSwitch

		Switch $Guiscape.FormManager.Handler($event)
			Case True
				Local $form = $Guiscape.FormManager.GetForm($event.Form)

				$Guiscape.FormManager.SetActiveForm($form)

				ContinueLoop
		EndSwitch

		Switch $Guiscape.Toolbar.Handler($event.ID)
			Case "Form"
				$Guiscape.CreateForm()

				ContinueLoop

			Case "Button"
				$Guiscape.State = GuiscapeCreate()

				ContinueLoop
		EndSwitch

		Switch $Guiscape.Tab.Handler($event.ID)
			Case "Canvas"
				$Guiscape.Canvas.Show

				ContinueLoop

			Case "Properties"
				$Guiscape.Canvas.Hide()

				$Guiscape.Properties.Show()

				ContinueLoop

			Case "Script"
				$Guiscape.Canvas.Hide()

				$Guiscape.Properties.Hide()

				ContinueLoop

			Case "Object Explorer"
				$Guiscape.Canvas.Hide()

				$Guiscape.Properties.Hide()

				ContinueLoop
		EndSwitch

		Switch $Guiscape.Menubar.Handler($event.ID)
			Case "Handled"
				ContinueLoop

			Case "Save"
				ContinueLoop

			Case "Load"
				ContinueLoop

			Case "Exit"
				Quit()
		EndSwitch
	Until False
EndFunc   ;==>GuiscapeCreate_Handler

Func Quit()
	Exit
EndFunc   ;==>Quit
