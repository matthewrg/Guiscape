
#include-once

#include "Model.au3"
#include "View.au3"

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")

	$this.AddProperty("View", $ELSCOPE_READONLY, CanvasView())
	$this.AddProperty("Model", $ELSCOPE_PRIVATE, CanvasModel())
	$this.AddProperty("Visible", $ELSCOPE_PRIVATE, Null)

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const $event)
	If $event.Form <> HWnd($this.View.Hwnd) Then Return False

	Switch $event.ID
		Case $this.View.ContextNewForm
			$this.Form.Create()

			Return True

		Case $GUI_EVENT_PRIMARYUP
			Return "Canvas"
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this, Const ByRef $parent)
	$this.View.Create($parent)
	
	$this.Visible = False
EndFunc   ;==>Canvas_Create

Func Canvas_Show(ByRef $this)
	If Not $this.Visible Then
		GUISetState(@SW_SHOW, HWnd($this.View.Hwnd))

		$this.Visible = True
	EndIf
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(ByRef $this)
	If $this.Visible Then
		GUISetState(@SW_HIDE, HWnd($this.View.Hwnd))

		$this.Visible = False
	EndIf
EndFunc   ;==>Canvas_Hide
