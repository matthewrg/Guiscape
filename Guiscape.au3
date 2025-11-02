#AutoIt3Wrapper_UseX64=Y

#include <ColorConstants.au3>

#include "AutoItObject.au3"
#include "Canvas\Canvas.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Properties\Properties.au3"
#include "Tab\Tab.au3"
#include "View.au3"
#include "Model.au3"

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)

_AutoItObject_Startup()

main()

Func main()
	Local $Guiscape = Guiscape()

	$Guiscape.Create()

	$Guiscape.Canvas.FormObject.Create()

	$Guiscape.Properties.FormStyles.Initialize($Guiscape.Canvas.FormObject.GetStyle())

	$Guiscape.Properties.FormExStyles.Initialize($Guiscape.Canvas.FormObject.GetExStyle())

	Do
		Local $event = $Guiscape.Model.EventArrayToMap(GUIGetMsg($GUI_EVENT_ARRAY))

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch

		Switch $Guiscape.Toolbar.Handler($event.ID)
			Case "Form"
				$Guiscape.Canvas.FormObject.Create()

				$Guiscape.Properties.FormStyles.Initialize($Guiscape.Canvas.FormObject.GetStyle())

				$Guiscape.Properties.FormExStyles.Initialize($Guiscape.Canvas.FormObject.GetExStyle())

				ContinueLoop

			Case "Button"
				$Guiscape.Canvas.FormObject.CreateButton()

				ContinueLoop
		EndSwitch

		Switch $Guiscape.Canvas.Handler($event)
			Case True
				ContinueLoop
		EndSwitch

		Switch $Guiscape.Tab.Handler($event.ID)
			Case "Canvas"
				$Guiscape.Canvas.Show

				$Guiscape.Properties.Hide()

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

			Case "GUI Defaults"
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
				Exit
		EndSwitch
	Until False
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Create", "Guiscape_Create")

	$this.AddProperty("Model", $ELSCOPE_READONLY, GuiscapeModel())
	$this.AddProperty("View", $ELSCOPE_READONLY, GuiscapeView())
	$this.AddProperty("Menubar", $ELSCOPE_READONLY)
	$this.AddProperty("Toolbar", $ELSCOPE_READONLY)
	$this.AddProperty("Tab", $ELSCOPE_READONLY, Tab())
	$this.AddProperty("Canvas", $ELSCOPE_READONLY, Canvas())
	$this.AddProperty("Properties", $ELSCOPE_READONLY, Properties())

	Return $this.Object
EndFunc   ;==>Guiscape

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

	$this.View.Show()

	$this.Canvas.Show()

	$this.Properties.Show()

	Return True
EndFunc   ;==>Guiscape_Create
