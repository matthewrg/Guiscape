#include-once

#include "..\AutoItObject.au3"
#include "GUI Object\GUI Object.au3"
#include "Model.au3"
#include "View.au3"

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("Form", "Canvas_Form")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")
	
	$this.AddProperty("ActiveObject", $ELSCOPE_READONLY)

	$this.AddProperty("View", $ELSCOPE_PRIVATE, CanvasView())
	$this.AddProperty("Model", $ELSCOPE_READONLY, CanvasModel())

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(Const ByRef $this, Const ByRef $event)
	Switch $event.Form
		Case HWnd($this.View.Hwnd)
			Switch $event.ID
				Case "Form", $this.View.NewForm
					$this.Form()

					Return True

				Case "Button"
					Return True

				Case $this.View.EraseCanvas
					Return "Erase Canvas"
			EndSwitch
	EndSwitch

	Switch $event.ID
		Case $GUI_EVENT_RESIZED
			$this.View.Move(WinGetPos($event.Form))	

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(Const ByRef $this, Const ByRef $parent)
	$this.View.Create($parent)
EndFunc   ;==>Canvas_Create

Func Canvas_Form(ByRef $this)
	Local $guiObject = GUIObject($this.View.Hwnd)
	
	$guiObject.Create("Form" & $this.Model.GetFormCount())
	
	$this.Model.AddForm($guiObject)
	
	$this.ActiveObject = $guiObject
	
	Return True
EndFunc

Func Canvas_Show(Const ByRef $this)
	$this.View.Show()
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(Const ByRef $this)
	$this.View.Hide()
EndFunc   ;==>Canvas_Hide
