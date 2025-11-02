#include-once

#include "..\AutoItObject.au3"
#include "Form Object\Form Object.au3"
#include "Model.au3"
#include "View.au3"

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")

	$this.AddProperty("FormObject", $ELSCOPE_READONLY)

	$this.AddProperty("View", $ELSCOPE_PRIVATE, CanvasView())
	$this.AddProperty("Model", $ELSCOPE_PRIVATE, CanvasModel())
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, False)

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const $event)
	If ($event.FormHwnd) <> ($this.View.Hwnd) Then Return False

	Switch $event.ID
		Case "Form"
			$this.FormObject.Create()

			Return True

		Case "Button"
			$this.FormObject.CreateButton()

			Return True

		Case $this.View.ContextNewForm
			$this.FormObject.Create()

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this, Const ByRef $parent)
	$this.View.Create($parent)

	$this.FormObject = FormObject($this.View.Hwnd)
EndFunc   ;==>Canvas_Create

Func Canvas_Show(ByRef $this)
	If Not $this.Visible Then
		GUISetState(@SW_SHOWNORMAL, HWnd($this.View.Hwnd))

		$this.Visible = True
	EndIf
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(ByRef $this)
	If $this.Visible Then
		GUISetState(@SW_HIDE, HWnd($this.View.Hwnd))

		$this.Visible = False
	EndIf
EndFunc   ;==>Canvas_Hide
