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

	Return $this.Object
EndFunc   ;==>Canvas

Func Canvas_Handler(ByRef $this, Const ByRef $event)
;~ 	If ($event.FormHwnd) <> HWnd($this.View.Hwnd) Then Return False

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
			
		Case $this.View.ContextErase
			Return "Erase Canvas"

		Case $GUI_EVENT_RESIZED
			Local Const $sizePos = WinGetPos($event.FormHwnd)

;~ 			ConsoleWrite("Guiscape:" & @CRLF & _
;~ 			             @TAB & "Left:   " & $sizePos[0] & @CRLF & _
;~ 					     @TAB & "Top:    " & $sizePos[1] & @CRLF & _
;~ 					     @TAB & "Width:  " & $sizePos[2] & @CRLF & _
;~ 					     @TAB & "Height: " & $sizePos[3] & @CRLF)

			WinMove(HWnd($this.View.Hwnd), '', 90 * $g_iDPI_ratio1, 30 * $g_iDPI_ratio1, ($sizePos[2] - (110 * $g_iDPI_ratio1)) * $g_iDPI_ratio1, ($sizePos[3] - (95 * $g_iDPI_ratio1)) * $g_iDPI_ratio1)

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Canvas_Handler

Func Canvas_Create(ByRef $this, Const ByRef $parent)
	$this.View.Create($parent)

	$this.FormObject = FormObject($this.View.Hwnd)
EndFunc   ;==>Canvas_Create

Func Canvas_Show(ByRef $this)
	$this.View.Show()
EndFunc   ;==>Canvas_Show

Func Canvas_Hide(ByRef $this)
	$this.View.Hide()
EndFunc   ;==>Canvas_Hide
