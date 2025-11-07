#include-once

#include "..\AutoItObject.au3"

#include <Array.au3>

Func CanvasModel()
	Local $formList[] = []

	Local $this = _AutoItObject_Class()

	$this.AddMethod("AddForm", "CanvasModel_AddForm")
	
	$this.AddProperty("FormCount", $ELSCOPE_READONLY, 0)

	$this.AddMethod("IncrementFormCount", "CanvasModel_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "CanvasModel_DecrementFormCount", True)

	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)

	Return $this.Object
EndFunc   ;==>CanvasModel

Func CanvasModel_AddForm(ByRef $this, $form)
	$this.IncrementFormCount()	
	
	Local $formList = $this.FormList
	
	_ArrayAdd($formList, $form)
	
	ConsoleWrite("GUI Object: " & $form.GetTitle() & @CRLF)
	
	$this.FormList = $formList
EndFunc

Func CanvasModel_IncrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount + 1
EndFunc   ;==>CanvasModel_IncrementFormCount

Func CanvasModel_DecrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount - 1
EndFunc   ;==>CanvasModel_DecrementFormCount
