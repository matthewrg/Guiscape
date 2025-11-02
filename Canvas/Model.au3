
#include-once

Func CanvasModel()
	Local $formList[]

	Local $this = _AutoItObject_Class()

	$this.AddMethod("AddForm", "CanvasModel_AddForm")

	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)

	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	$this.AddMethod("IncrementFormCount", "CanvasModel_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "CanvasModel_DecrementFormCount", True)

	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>CanvasModel

Func CanvasModel_IncrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount + 1
EndFunc   ;==>CanvasModel_IncrementFormCount

Func CanvasModel_DecrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount - 1
EndFunc   ;==>CanvasModel_DecrementFormCount
