#include-once

Func Canvas()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "Canvas_Handler")
	$this.AddMethod("Create", "Canvas_Create")
	$this.AddMethod("GetHwnd", "Canvas_GetHwnd")
	$this.AddMethod("Show", "Canvas_Show")
	$this.AddMethod("Hide", "Canvas_Hide")
	$this.AddMethod("Move", "Canvas_Move")

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(Const ByRef $this, Const ByRef $event)
	Switch $event.Form
		Case $this.View.Hwnd
			Switch $event.ID
				Case $this.View.NewForm
					Return "New Form"

				Case $this.View.EraseCanvas
					Return "Erase Canvas"
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(Const ByRef $this, Const ByRef $parent)
	$this.View.Create($parent)
EndFunc   ;==>Canvas_Create

Func Canvas_GetHwnd(Const ByRef $this)
	Return $this.View.Hwnd
EndFunc

Func Canvas_Show(Const ByRef $this)
	$this.View.Show()
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(Const ByRef $this)
	$this.View.Hide()
EndFunc   ;==>Canvas_Hide

Func Canvas_Move(Const ByRef $this, Const ByRef $sizePos)
	$this.View.Move($sizePos)
EndFunc   ;==>Canvas_Move
